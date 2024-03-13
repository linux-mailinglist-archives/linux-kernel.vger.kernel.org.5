Return-Path: <linux-kernel+bounces-102470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FACB87B28B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F371C25ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BA64D59F;
	Wed, 13 Mar 2024 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iM+JUJNL"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351A4D117
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360399; cv=none; b=hUs8MV8dTM0rYk4IEaayCLJfpVvFDLcR0M8DudzzHWXjLXDADGGr6h7zXrjcX++qSpEXdzOIBUUaGzLuijK4JcEOK63T/ksi+QZUpVqlWvdAGvxLsXYfFTjuI2rp7y6n55fzKN9cWwgNtuMwsbu+4Q32DedphuZ+LZKS3gncsQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360399; c=relaxed/simple;
	bh=EdZmblZCyUf4OyNCIWooUUfPlEk+qqlfYOVb6A/ZZDI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fBMsOTzhK5wauw6AtETB9YnMdXis90NesZTgCtNSRY2WCI6W1f2Ug9RtPbDZ18YGLlTBKVonflBOVKQunEMKIFRvtq+JNtfwfSDLGF9OU3vtz9dnvdZjD3vMqGjGWPzlB4UQjJrbdHTms4v7N25XAXT5l4qX83EAu5qPU4c87SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iM+JUJNL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-788598094c4so14313285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1710360397; x=1710965197; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIa9HI35t5yNIIVvbINr9MM3CM3VScxjoKWZlSOiIjg=;
        b=iM+JUJNL0bB/wwBAR3YkOY6Wcd3J2sMNpc7BVQv2RK1a+8kdo0i63/tKgDafiuvY05
         FFr1/EKY8rCwJTiI/WxMFToP16RH8JtnDFK99CM1pSMyVmikGqtBByUZRhoQAQJCKrsl
         yRKMeyfDn9WvGrRLSqnlwhKqmWBHfiQTkAhC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710360397; x=1710965197;
        h=in-reply-to:autocrypt:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nIa9HI35t5yNIIVvbINr9MM3CM3VScxjoKWZlSOiIjg=;
        b=ogIncBJB1JP1V3CUewgvL6PfPdjD+rFJ5HUYyT27XiBwcbDwO4oR5sLN8snRQbEzWI
         bvhCa8IRNmhqIm0AwlrgUyc8ifTPqbTCn967ZGP3MopD8MCIDRk0zuLCHKnOFKT8IJuC
         lzqMmHBd/fOxvlpE00i9pbh9G32VJaRrwuJCs/M9rMwc3wlAJ+FP/E8UlxRKEQsXvmCv
         ByCDuYR1ubYlau/z5+lNr30NAH1S6Kk7vgJg0kabmJsn1mSwCIX9I3xW0pM7Ig4iFcNk
         Osfg0oZkKD78/qHurW9NXDq8NiBwfZ6zLd38dW+m55BQQcIepfuyETdWZntT8sjyiXVu
         jtkA==
X-Forwarded-Encrypted: i=1; AJvYcCWrj1cvk78OtbWKL+ilFxXDeSOnJnm9bBLTMLGlvuw06Pc46OzCkq2dP8kPWB444Pn1CSKI0c3KEokpVqynfL2sRuK2m5L0ZoWHbaR1
X-Gm-Message-State: AOJu0Yy4SpFUYKtwa63sWHPnXnu1Vcq9V6kY7PMx5CTH5jcv0cvc94tB
	flLM92s96dgH3PUs0af1vbkp5n9htuOkuDkiV3alBDjY9WrFr6jyyH1LoGrqnQ==
X-Google-Smtp-Source: AGHT+IGPNf7LHKdyXcx08nGLM4prwoDKQdJPCBAoLkdGaS+EaKagverG34hyR4UOXWm5IUsLvYjuZw==
X-Received: by 2002:a37:de08:0:b0:788:723e:1e16 with SMTP id h8-20020a37de08000000b00788723e1e16mr868834qkj.51.1710360397078;
        Wed, 13 Mar 2024 13:06:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 13-20020a05620a04cd00b007889711592dsm1835187qks.110.2024.03.13.13.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 13:06:36 -0700 (PDT)
Message-ID: <493cdb11-72b7-4d03-b982-448451fd5824@broadcom.com>
Date: Wed, 13 Mar 2024 13:06:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: Fix error code checking in spi_mem_exec_op()
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Michael Walle <mwalle@kernel.org>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240313171050.3505620-1-florian.fainelli@broadcom.com>
 <CZSSWP7A9UM7.1R20796VHLU0F@kernel.org> <mafs0o7bic7fs.fsf@kernel.org>
 <9420b802-5361-4f47-a069-52c43f5fd253@broadcom.com>
 <mafs0il1qc4n2.fsf@kernel.org>
 <56318d3f-1d5a-4a73-9d3a-e7ebc66860d9@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <56318d3f-1d5a-4a73-9d3a-e7ebc66860d9@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ee0b2b0613904ff6"

--000000000000ee0b2b0613904ff6
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/13/24 12:34, Florian Fainelli wrote:
> On 3/13/24 12:29, Pratyush Yadav wrote:
>> On Wed, Mar 13 2024, Florian Fainelli wrote:
>>
>>> On 3/13/24 11:28, Pratyush Yadav wrote:
>>>> On Wed, Mar 13 2024, Michael Walle wrote:
>>>>
>>>>> On Wed Mar 13, 2024 at 6:10 PM CET, Florian Fainelli wrote:
>>>>>> After commit cff49d58f57e ("spi: Unify error codes by replacing 
>>>>>> -ENOTSUPP with
>>>>>> -EOPNOTSUPP"), our SPI NOR flashes would stop probing with the 
>>>>>> following
>>>>>> visible in the kernel log:
>>>>>>
>>>>>> [    2.196300] brcmstb_qspi f0440920.qspi: using bspi-mspi mode
>>>>>> [    2.210295] spi-nor: probe of spi1.0 failed with error -95
>>>>>>
>>>>>> It turns out that the check in spi_mem_exec_op() was changed to check
>>>>>> for -ENOTSUPP (old error code) or -EOPNOTSUPP (new error code), 
>>>>>> but this
>>>>>> means that for drivers that were converted, the second condition 
>>>>>> is now
>>>>>> true, and we stop falling through like we used to. Fix the error to
>>>>>> check for neither error being neither -ENOTSUPP *nor* -EOPNOTSUPP.
>>>>>>
>>>>>> Fixes: cff49d58f57e ("spi: Unify error codes by replacing 
>>>>>> -ENOTSUPP with -EOPNOTSUPP")
>>>>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>>>> Change-Id: I4159811f6c582c4de2143382473d2000b8755872
>>>>>
>>>>> Ha, thank you!
>>>>>
>>>>> Reviewed-by: Michael Walle <mwalle@kernel.org>
>>>>>
>>>>> FWIW in next, there is commit
>>>>> e63aef9c9121e ("spi: spi-mem: add statistics support to ->exec_op() 
>>>>> calls")
>>>>> that probably will conflict with this one.
>>>>>
>>>>> Also, - not for this patch - but with that logic, spi_mem_exec_op()
>>>>> might return EOPNOTSUPP *or* ENOTSUPP, even for drivers which might
>>>>> still return ENOTSUPP, because there is one condition in
>>>>> spi_mem_exec_op() which will always return EOPNOTSUPP. That is
>>>>> somewhat confusing, no?
>>>> I agree. I suppose it would be better to do:
>>>>       if (!ret)
>>>>          return 0;
>>>>       if (ret == -ENOTSUPP || ret == -EOPNOTSUPP)
>>>>          return -EOPNOTSUPP;
>>>>
>>>
>>> But with e63aef9c9121e ("spi: spi-mem: add statistics support to 
>>> ->exec_op()
>>> calls") applied, would not that mean duplicating the statistics 
>>> gathering, or
>>> were the statistics gathering only intended for when ret == 0?
>>
>> Hmm, I didn't properly understand this. Ignore my suggestion. Your patch
>> does the right thing.
> 
> What I meant is that e63aef9c9121e will increment statistics not just 
> when we return 0 from ctlr->mem_ops->exec_op, but also if we return 
> -ENOTSUPP or -EOPNOTSUPP, and I am  not sure if this is exactly what is 
> intended. But this is somewhat orthogonal.

It looks like the handling of a non-zero return code will fall either in 
the -ETIMEDOUT category, or in the general category of an error. I 
suppose there is a question whether a operation that could not be 
supported should fall in the "error" category.
-- 
Florian


--000000000000ee0b2b0613904ff6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICpoQvC+NQEEOnnR
rmOJiMFCqDgsGKCi2i2LV1yzmZ8jMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDMxMzIwMDYzN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAG0MnpAAFMCYhyU5PYOVPAe13NU4lOqBRp
UjFMc5HL27mNzsoqd+z82WCie/byAolWjWtl9EaJOigSvn89f6plW1ELqAONPqc4KZabnPa8G18H
B1lhQrCuonf6pyQSxncigi4Aoxy3CccYajejx3+D9fbaRGuAq94tkhAI2Bj78x2uxOo3kJwR4aKu
6eSM6H8npBj+nVOKCQuRmSIo0uJZu/HuWOJHz0Mya+elXcPHF2vQLVa95b+z3clWCxQU7PYW3+5S
aPEibKeJJ3LnPbgAaLLg1an4MkyRdOjxKNxvntUfRNnTjBqsnUtfBsXP7UbTaw6vyXdfnV3zHw/G
YWMQ
--000000000000ee0b2b0613904ff6--

