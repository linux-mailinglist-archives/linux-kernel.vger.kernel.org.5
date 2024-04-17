Return-Path: <linux-kernel+bounces-147838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431518A7A60
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA551C21439
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E286FB9;
	Wed, 17 Apr 2024 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvdsn.com header.i=@jvdsn.com header.b="Zw2hFAYe"
Received: from smtp.jvdsn.com (smtp.jvdsn.com [129.153.194.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F695244;
	Wed, 17 Apr 2024 02:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.153.194.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319969; cv=none; b=FNONm+r86tMISi5THveIdO625lkKAIpVoKs2GagTmfpgGJN7jI6FZMrDX7iXg/DZ2oxG7Azi1nO3wUcGLs0s/LKCBb6iY8jk88+05weSXb0UXL0mG3vtVDDFe9wb+b/u3rZbZW9Ts73cKsSogg7kxCjGg62gTDY1qGmTgKh95Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319969; c=relaxed/simple;
	bh=ZiGsFSryOOKe9OzBTaWucuXuaI2CiQx4hLJ+0X+WGs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzog7SZI5A6340VFUP2OYXm5isavMz5Pwe/G/XTL4xP8TWU3UC63NKonh/FTM/CqAxhe4j1JXOZ0FBI28frcc+n4mESim63D0LEJwcIUUPktzy+MuoiqTk+fSh7vUVFYy92n6+lswE8PYj+ON143CryKczO2olqPF3riTDDxVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jvdsn.com; spf=pass smtp.mailfrom=jvdsn.com; dkim=pass (2048-bit key) header.d=jvdsn.com header.i=@jvdsn.com header.b=Zw2hFAYe; arc=none smtp.client-ip=129.153.194.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jvdsn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvdsn.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jvdsn.com; s=mail;
	t=1713319967; bh=ZiGsFSryOOKe9OzBTaWucuXuaI2CiQx4hLJ+0X+WGs0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Zw2hFAYe/WnkAYjKW4AeJUMukSoVUYgRGKmm9m4pbWRUzkECDXhwyTLDo0ufmZ0XZ
	 YWrR9gwzrHI+lNOWJ8xdg0WTLMvSI/fHpm+cqyzivDpJUx+Q2SvrVqKGS/VKImm9zm
	 Gtm7tkA0jX9lXlvGmETdpg0qLZgQO3Gfavza28LHZOvs2Ski7LLlhCgejKubkq6vCs
	 i30bHVdy1B89uBaL15M8suT4v4hie3ZV8jVlHKOoOCVSXTW9nw4zFSWl8aGsTfvWaw
	 AIfJeI7GIsARAga7rDh5j2OZjGp/K1Wn4u1auqmlvvw61Ihte8up+D1o5++DyIN5rG
	 ZGXrW/WLQLeEg==
Message-ID: <04f5265f-77e6-45cc-856c-45cd80c278c2@jvdsn.com>
Date: Tue, 16 Apr 2024 21:12:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] crypto: ecdh - Pass private key in proper byte order
 to check valid key
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, ardb@kernel.org,
 salvatore.benedetto@intel.com, davem@davemloft.net,
 Jarkko Sakkinen <jarkko@kernel.org>, linux-crypto@vger.kernel.org,
 herbert@gondor.apana.org.au
References: <20240415003026.2661270-1-stefanb@linux.ibm.com>
 <20240415003026.2661270-2-stefanb@linux.ibm.com>
 <D0KX9NQPXKO1.2RXZU000DD1BB@kernel.org>
 <6442f387-e45e-4019-8af0-6ca309e4ce4f@linux.ibm.com>
 <D0LM72MR4LDH.3QN2WEXU4QEEJ@kernel.org>
Content-Language: en-US
From: Joachim Vandersmissen <git@jvdsn.com>
In-Reply-To: <D0LM72MR4LDH.3QN2WEXU4QEEJ@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Apologies for hijacking this thread, but I don't have access to the 
older emails.

Should the new priv variable not be zeroized before the end of the 
function? As it contains private keying material?

Kind regards,
Joachim

On 4/16/24 9:25 AM, Jarkko Sakkinen wrote:
> On Tue Apr 16, 2024 at 3:51 AM EEST, Stefan Berger wrote:
>>
>> On 4/15/24 14:53, Jarkko Sakkinen wrote:
>>> On Mon Apr 15, 2024 at 3:30 AM EEST, Stefan Berger wrote:
>>>> ecc_is_key_valid expects a key with the most significant digit in the last
>>>> entry of the digit array. Currently ecdh_set_secret passes a reversed key
>>>> to ecc_is_key_valid that then passes the rather simple test checking
>>>> whether the private key is in range [2, n-3]. For all current ecdh-
>>>> supported curves (NIST P192/256/384) the 'n' parameter is a rather large
>>>> number, therefore easily passing this test.
>>>>
>>>> Throughout the ecdh and ecc codebase the variable 'priv' is used for a
>>>> private_key holding the bytes in proper byte order. Therefore, introduce
>>>> priv in ecdh_set_secret and copy the bytes from ctx->private_key into
>>>> priv in proper byte order by using ecc_swap_digits. Pass priv to
>>>> ecc_is_valid_key.
>>>>
>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>> Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> ---
>>>>    crypto/ecdh.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/crypto/ecdh.c b/crypto/ecdh.c
>>>> index 3049f147e011..a73853bd44de 100644
>>>> --- a/crypto/ecdh.c
>>>> +++ b/crypto/ecdh.c
>>>> @@ -27,6 +27,7 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
>>>>    			   unsigned int len)
>>>>    {
>>>>    	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
>>>> +	u64 priv[ECC_MAX_DIGITS];
>>>>    	struct ecdh params;
>>>>    
>>>>    	if (crypto_ecdh_decode_key(buf, len, &params) < 0 ||
>>>> @@ -40,9 +41,10 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
>>>>    				       ctx->private_key);
>>>>    
>>>>    	memcpy(ctx->private_key, params.key, params.key_size);
>>>> +	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
>>> Does swapping speed up the test that follows are what effect does it
>>> have to the ecc_is_key_valid() call?
>> The goal of this particular patch is to fix an issue with the byte order
>> (as description says) and, as you can see in the 2nd patch, private key
>> is always copied into priv using ecc_swap_digits before priv is being
>> used instead of ctx->private_key (or whatever it is called in the
>> function it was passed to). This patch here has nothing to do with speed
>> up but a) fixing an issue and b) using priv here as well, so fixing this
>> 'outlier' here. The speed-up comes in the 2nd patch when the bytes in
>> ctx->private_key are put into proper order right away and we can get rid
>> if priv, taking the swapped bytes of ctx->private_key, everywhere and we
>> can use ctx->private_key directly.
>>
>> The test harness (testmgr.c) runs through part of this code here
>> providing the private key that is copied into ctx->private_key, so it's
>> being used and when you make a mistake (making the changes I did) the
>> ecdh test cases will fail.
> OK, thanks for the explanation :-) No opposition on the change itself.
>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> BR, Jarkko
>

