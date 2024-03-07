Return-Path: <linux-kernel+bounces-96093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2E98756FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D37283C31
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC0C137C25;
	Thu,  7 Mar 2024 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MrwwIH4D"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341D2135A7E;
	Thu,  7 Mar 2024 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839235; cv=none; b=hVXTw3/eHURBaD/7XiOUoGc388Kbc05EWaohb5Z7JUgc6Uqlh7PI58rCj8svn26M9mK+qPn9IN/BsFJbJN+f5w69lnyYgC0zAL5fmA+Z9RoWTZuyy8cmWjXWPgJLRfvIzYspM6AkBcGBXIjsoyQGNNtVVzHnoB02xIOzL+ACcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839235; c=relaxed/simple;
	bh=9IU5mpnakOs+5J1LevBlkxNvYwaZJfrw6QKmQ6NaSSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUgfVa+e0DWJbXjq7sgoNvHX8XYeBG73LKVg5SID1g4Hr9Atuai5WAMBw/8BLMYTekUO0GNHDhkO8kGsreeHXTSDLvi37erJczq0uAzeXvo3Wik74af92bHzpeKEUkqPur+t2Ja4gEQaadY5Q3YOc9a5ApimT70TO83l4if6gLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MrwwIH4D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427JGu7g025966;
	Thu, 7 Mar 2024 19:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Vk4QugbaeYKAnB1a540+QpoGeFz71wRAP+xSfPiVcZk=;
 b=MrwwIH4Du1ZeN8EKx0J/Efb0gDySc9iuFsDTpaVZBzjYcnwxqNzthL2iQh33tefRxGpg
 VjYqnRnSoxrs26hnpU87/+8grq/cyIpNxAgGy7ZT2IyNyaxMkBaOlYajCARBYFx0oMKs
 3MrWcjLAfn0WD3emz522jzZ07ZL7GZhvYYesQnjRM5SKb5OeL5YvEMQ8tq7jHRheOJZZ
 BQu83YLKzlb3ASKuh9tfeSLBRY9K0A2jXmWJl8KzytW1Us1dJp2KkxF7Qv3mv15Tq5+Q
 Dreacqbv/rpn+EU0QrMlhQGLanEDPPoRpNQYsKkHYvY3YYe8muOTeaLZh0dfe2Ggijuo NA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqkbwgab1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 19:20:17 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 427Ii6VB006051;
	Thu, 7 Mar 2024 19:20:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeetfxhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 19:20:16 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 427JKDG130867814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 19:20:16 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF59F58069;
	Thu,  7 Mar 2024 19:20:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B402158053;
	Thu,  7 Mar 2024 19:20:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 19:20:12 +0000 (GMT)
Message-ID: <571aa199-00cc-4153-9424-0012d20dc6f6@linux.ibm.com>
Date: Thu, 7 Mar 2024 14:20:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] crypto: ecdsa - Rename keylen to bufsize where
 necessary
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
 <20240306222257.979304-10-stefanb@linux.ibm.com>
 <CZNR9UY8J7Q0.2R1YYTOO4Z92G@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZNR9UY8J7Q0.2R1YYTOO4Z92G@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CCXseWuHPD1wYyiCkKCweDSlPR_abUD9
X-Proofpoint-ORIG-GUID: CCXseWuHPD1wYyiCkKCweDSlPR_abUD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403070135



On 3/7/24 14:13, Jarkko Sakkinen wrote:
> On Thu Mar 7, 2024 at 12:22 AM EET, Stefan Berger wrote:
>> In some cases the name keylen does not reflect the purpose of the variable
>> anymore once NIST P521 is used but it is the size of the buffer. There-
>> for, rename keylen to bufsize where appropriate.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Tested-by: Lukas Wunner <lukas@wunner.de>
>> ---
>>   crypto/ecdsa.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
>> index 4daefb40c37a..4e847b59622a 100644
>> --- a/crypto/ecdsa.c
>> +++ b/crypto/ecdsa.c
>> @@ -35,8 +35,8 @@ struct ecdsa_signature_ctx {
>>   static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
>>   				  const void *value, size_t vlen, unsigned int ndigits)
>>   {
>> -	size_t keylen = ndigits * sizeof(u64);
> 
> nit: still don't get why "* sizeof(u64)" would ever be more readable
> thean "* 8".

Because existing code in crypto uses sizeof(u64) when converting ndigits 
to number of bytes and '8' is not used for converting to bytes. Do we 
need to change this now ? No, I think it's better to conform to existing 
code.

# grep -rI ndigits crypto/ | grep sizeof\(u64\)
crypto/ecrdsa.c:        unsigned int ndigits = req->dst_len / sizeof(u64);
crypto/ecrdsa.c:            req->dst_len != ctx->curve->g.ndigits * 
sizeof(u64) ||
crypto/ecrdsa.c:        vli_from_be64(r, sig + ndigits * sizeof(u64), 
ndigits);
crypto/ecrdsa.c:            ctx->curve->g.ndigits * sizeof(u64) != 
ctx->digest_len)
crypto/ecrdsa.c:            ctx->key_len != ctx->curve->g.ndigits * 
sizeof(u64) * 2)
crypto/ecrdsa.c:        ndigits = ctx->key_len / sizeof(u64) / 2;
crypto/ecrdsa.c:        vli_from_le64(ctx->pub_key.y, ctx->key + ndigits 
* sizeof(u64),
crypto/ecrdsa.c:        return ctx->pub_key.ndigits * sizeof(u64);
crypto/ecdh.c:      params.key_size > sizeof(u64) * ctx->ndigits)
crypto/ecc.c:   size_t len = ndigits * sizeof(u64);
crypto/ecc.c:           num_bits = sizeof(u64) * ndigits * 8 + 1;
crypto/ecdsa.c: size_t bufsize = ndigits * sizeof(u64);
crypto/ecdsa.c: size_t bufsize = ctx->curve->g.ndigits * sizeof(u64);
crypto/ecdsa.c: ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));

    Stefan

> 
> BR, Jarkko

