Return-Path: <linux-kernel+bounces-147856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894808A7A99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6C11C20C98
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A1B8F72;
	Wed, 17 Apr 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Em/FVgv2"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF1D63A;
	Wed, 17 Apr 2024 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321121; cv=none; b=X388fxoJBZY3brVAypUIiMpac7PT2IIG80xn6e1HwzyyWK/NDC1ok8eCM3zOYcxyjFi2qgs2R9foEFUap7ulkgAZwIo1cb4+LvhbbrJxlTVcG3C3sZpfxZdCADTs1S0VGIIYHoktrY16l7BVaEeWzWOypNMJ1hwwe+snsnCKvv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321121; c=relaxed/simple;
	bh=pJXEiAyGZemue94rYtVKwPx+ofEz0A4fLee0Q/RCSew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNTL39JguDMCL5oz64rTFGA5NPApWJa70Pmof2ViZzlHj34RIX9yd/O8RPl0f2b8WtavcpxQq7qEIM2gVDJJcCr21cgt182f43coNR6N/d7yjPiQkSY3T2UPsbq+0lnZPZB6rYGwnksQ1m31nxhar0giePpqLwwGY68C7zqpUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Em/FVgv2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43H2RQ7E026409;
	Wed, 17 Apr 2024 02:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7dJE3cf/q7to4rsvlLaRvJk1ImXMlM5MdrO+aUuojGQ=;
 b=Em/FVgv2bmUQHB28yHxZaBaaDALPEXffshRrDmjVnbK/wBMdzaQacTg7rn8lmlIl70kj
 O9bGIdXTOTUAaYcwh1TngnqjvBjSmbU1N3zUBNsf7Rw9JP/p9MRUPONtDjeS5xC5TlRK
 eLNB/y9J3Zc/k7UvEu5qzK6wHbdDhpMU6+xq0VtTDDzJLq0RJJz1WqcqlhKh/qZrpNSQ
 vAX2iqXXU1BLcV9VkSkCU3G386+LQjwQAd1RScqNJwbhRPEF8jC+n0ErY8EE7bgrrS2H
 LBtTLi43B2lykcPJOXzejeYUFIprYO3DsOPIYVRcs/alKlq3zdWdbYuAYWFkCyJH0Yly qQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xj5nb0063-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 02:31:49 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43GNMLCg021351;
	Wed, 17 Apr 2024 02:31:48 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg6kkhd8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 02:31:48 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43H2VjIi27656774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 02:31:48 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8E8A5804B;
	Wed, 17 Apr 2024 02:31:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E5A95806A;
	Wed, 17 Apr 2024 02:31:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Apr 2024 02:31:44 +0000 (GMT)
Message-ID: <1ec8e98f-6b65-49b4-8429-26d598fc305f@linux.ibm.com>
Date: Tue, 16 Apr 2024 22:31:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] crypto: ecdh - Pass private key in proper byte order
 to check valid key
Content-Language: en-US
To: Joachim Vandersmissen <git@jvdsn.com>
Cc: linux-kernel@vger.kernel.org, ardb@kernel.org,
        salvatore.benedetto@intel.com, davem@davemloft.net,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au
References: <20240415003026.2661270-1-stefanb@linux.ibm.com>
 <20240415003026.2661270-2-stefanb@linux.ibm.com>
 <D0KX9NQPXKO1.2RXZU000DD1BB@kernel.org>
 <6442f387-e45e-4019-8af0-6ca309e4ce4f@linux.ibm.com>
 <D0LM72MR4LDH.3QN2WEXU4QEEJ@kernel.org>
 <04f5265f-77e6-45cc-856c-45cd80c278c2@jvdsn.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <04f5265f-77e6-45cc-856c-45cd80c278c2@jvdsn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l3lTfBWc92C1SOASiagGej4FLd4rSARx
X-Proofpoint-GUID: l3lTfBWc92C1SOASiagGej4FLd4rSARx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_01,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170016



On 4/16/24 22:12, Joachim Vandersmissen wrote:
> Hi,
> 
> Apologies for hijacking this thread, but I don't have access to the 
> older emails.
> 
> Should the new priv variable not be zeroized before the end of the 
> function? As it contains private keying material?

Yes, fixed in v2.

    Stefan

> 
> Kind regards,
> Joachim
> 
> On 4/16/24 9:25 AM, Jarkko Sakkinen wrote:
>> On Tue Apr 16, 2024 at 3:51 AM EEST, Stefan Berger wrote:
>>>
>>> On 4/15/24 14:53, Jarkko Sakkinen wrote:
>>>> On Mon Apr 15, 2024 at 3:30 AM EEST, Stefan Berger wrote:
>>>>> ecc_is_key_valid expects a key with the most significant digit in 
>>>>> the last
>>>>> entry of the digit array. Currently ecdh_set_secret passes a 
>>>>> reversed key
>>>>> to ecc_is_key_valid that then passes the rather simple test checking
>>>>> whether the private key is in range [2, n-3]. For all current ecdh-
>>>>> supported curves (NIST P192/256/384) the 'n' parameter is a rather 
>>>>> large
>>>>> number, therefore easily passing this test.
>>>>>
>>>>> Throughout the ecdh and ecc codebase the variable 'priv' is used for a
>>>>> private_key holding the bytes in proper byte order. Therefore, 
>>>>> introduce
>>>>> priv in ecdh_set_secret and copy the bytes from ctx->private_key into
>>>>> priv in proper byte order by using ecc_swap_digits. Pass priv to
>>>>> ecc_is_valid_key.
>>>>>
>>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>>> Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>
>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>> ---
>>>>>    crypto/ecdh.c | 4 +++-
>>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/crypto/ecdh.c b/crypto/ecdh.c
>>>>> index 3049f147e011..a73853bd44de 100644
>>>>> --- a/crypto/ecdh.c
>>>>> +++ b/crypto/ecdh.c
>>>>> @@ -27,6 +27,7 @@ static int ecdh_set_secret(struct crypto_kpp 
>>>>> *tfm, const void *buf,
>>>>>                   unsigned int len)
>>>>>    {
>>>>>        struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
>>>>> +    u64 priv[ECC_MAX_DIGITS];
>>>>>        struct ecdh params;
>>>>>        if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
>>>>> @@ -40,9 +41,10 @@ static int ecdh_set_secret(struct crypto_kpp 
>>>>> *tfm, const void *buf,
>>>>>                           ctx->private_key);
>>>>>        memcpy(ctx->private_key, params.key, params.key_size);
>>>>> +    ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
>>>> Does swapping speed up the test that follows are what effect does it
>>>> have to the ecc_is_key_valid() call?
>>> The goal of this particular patch is to fix an issue with the byte order
>>> (as description says) and, as you can see in the 2nd patch, private key
>>> is always copied into priv using ecc_swap_digits before priv is being
>>> used instead of ctx->private_key (or whatever it is called in the
>>> function it was passed to). This patch here has nothing to do with speed
>>> up but a) fixing an issue and b) using priv here as well, so fixing this
>>> 'outlier' here. The speed-up comes in the 2nd patch when the bytes in
>>> ctx->private_key are put into proper order right away and we can get rid
>>> if priv, taking the swapped bytes of ctx->private_key, everywhere and we
>>> can use ctx->private_key directly.
>>>
>>> The test harness (testmgr.c) runs through part of this code here
>>> providing the private key that is copied into ctx->private_key, so it's
>>> being used and when you make a mistake (making the changes I did) the
>>> ecdh test cases will fail.
>> OK, thanks for the explanation :-) No opposition on the change itself.
>>
>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>>
>> BR, Jarkko
>>

