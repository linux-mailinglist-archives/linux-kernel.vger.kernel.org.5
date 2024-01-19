Return-Path: <linux-kernel+bounces-31495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF262832F03
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666F01F25FED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA93537E2;
	Fri, 19 Jan 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="iXdP/QeK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7DAA21
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689472; cv=none; b=nX1XT3OLBcDGMAWq8nirfkcxXq2Zx8decO3HuT0QDy5D4cIeTMLwmz+CNtk/pHfTRZnOM8ukOMyoMDfZh3/2y/xDRcRqdn/jYr8fhe42zjEXzl4c3mILOI+TbsYH/4v7K7KaWbVEBCvSE4EgPsmhc3bR0qJXhi7r94U9B39EhEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689472; c=relaxed/simple;
	bh=uXMy1n0JH4qt7XiFd4zzgMTGI/G2SpHNvq70Xpl60kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxibRjeiGDfhzTy4zbSBJtBNEWgy+2RZXQW9KYTEYdztzRCaleX/qk3qn7BU6YAiGRUtbqVTOcXl3jftGT/QKWu/udzCLRAhqKk3I7IVukWvIxl573eBXr+Qg7ZeEKCeMO+3tJQch8cchcj8OwlQPu0WXLtCpEjejY9pzoz54iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=iXdP/QeK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so11693935e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1705689468; x=1706294268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+1r/dahOeE8P7NrmGZ2J2uPqXQodmhqgoO/0IR34I0=;
        b=iXdP/QeKo2TcYW18yATTj0/NNCUPlgJA985I+94I5l/MFIYK2aVT4acyQr+ZcFxUK7
         1NW96c0JpTxOcaJCPTxKlvS6VdTwZN7wYEOuZ68PrQsCS58UhGviDSZ6x0qngB0jB9kh
         zuVbYhiOTkBFtnjCfMUzy8DI/yMjvoFfKMMVq4FQPGYaZ5gkJxQgKwiZq9/bh/wfeFb/
         QKhgv4AHl4mkAkg7Zxd/nkuAYLTZn7U08gGJqFuXh3djgbobxcBl65oaVJ3KQ75rJom3
         WBTcZpIAFR9waJJCXk9iSc6K3ZwOQm2K55uETMmMFHgLSItTd8+Q7hHBb0kangzjdoCV
         HsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705689468; x=1706294268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+1r/dahOeE8P7NrmGZ2J2uPqXQodmhqgoO/0IR34I0=;
        b=fJBR0I6AyZr8Zqk3ho61SvHbgoUmiev9Cg7HghQwpR0V6cOLup/1LTybmMJxA4r6G/
         dqlmT6vHtw6pjpRxEAIANSRkh9Fr2ebrCpcj0huuoW2rFlev2QxyYCtva2aeFnpFKEB+
         1LKeM80JSYScdJmRfCCcp8mGRBe8AQu6VIZDP/u9dVMaWqVLr70CzzkldR2zAJ2bbD57
         c2/ZVDs44xe3sQefRmZSbjFj2U/8NsKOwJF2tLKQjWDQ+60qE0ByaNeGhK+P7re+2Hzm
         otqzol8jWZPKDW3FcBXDBxCA8Y1J3pEx4qOjB4o9bs4OMIqxVSMXqYXyTkYjI68/S86U
         gmVQ==
X-Gm-Message-State: AOJu0YwVmGmwEs/LN/tjSvmJjBhxUatR3fbjXuZJfqvxAUj1Ym2QztfG
	Owsq5t13fn8izFs/ts78XaMuj4U1+eFzYWn3xk+ldb/CAjrRJ82ybrRqdFC3nw==
X-Google-Smtp-Source: AGHT+IGTV33BFQ4quwL/xLL89bS64SKyLDdVok833PiG97Szn5n2sRugxrO/C21q3HmJZQJUt79rvA==
X-Received: by 2002:a05:600c:26d2:b0:40e:4a0a:10b2 with SMTP id 18-20020a05600c26d200b0040e4a0a10b2mr73610wmv.170.1705689468291;
        Fri, 19 Jan 2024 10:37:48 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0040e5951f199sm29697280wmq.34.2024.01.19.10.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 10:37:47 -0800 (PST)
Message-ID: <945fb211-e224-4d81-aa12-9cfd5c066751@arista.com>
Date: Fri, 19 Jan 2024 18:37:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests/net: Clean-up double assignment
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Mohammad Nassiri
 <mnassiri@ciena.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
 <20240118-tcp-ao-test-key-mgmt-v1-3-3583ca147113@arista.com>
 <20240119162525.GF89683@kernel.org>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240119162525.GF89683@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon,

On 1/19/24 16:25, Simon Horman wrote:
> On Thu, Jan 18, 2024 at 02:51:36AM +0000, Dmitry Safonov wrote:
>> Yeah, copy'n'paste typo.
>>
>> Fixes: 3c3ead555648 ("selftests/net: Add TCP-AO key-management test")
>> Reported-by: Nassiri, Mohammad <mnassiri@ciena.com>
>> Closes: https://lore.kernel.org/all/DM6PR04MB4202BC58A9FD5BDD24A16E8EC56F2@DM6PR04MB4202.namprd04.prod.outlook.com/
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
> 
> Hi Dmitry,
> 
> This seems more like a clean-up than a fix.

Do you mean to remove the tag or that you'd prefer it rather go
to net-next?

>>  tools/testing/selftests/net/tcp_ao/lib/sock.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
>> index c75d82885a2e..923a9bb4f1ca 100644
>> --- a/tools/testing/selftests/net/tcp_ao/lib/sock.c
>> +++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
>> @@ -377,7 +377,6 @@ int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out)
>>  
>>  	key_dump[0].nkeys = nr_keys;
>>  	key_dump[0].get_all = 1;
>> -	key_dump[0].get_all = 1;
>>  	err = getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS,
>>  			 key_dump, &key_dump_sz);
>>  	if (err) {
>>
>> -- 
>> 2.43.0
>>

Thanks,
           Dmitry


