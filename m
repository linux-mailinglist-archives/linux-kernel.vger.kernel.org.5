Return-Path: <linux-kernel+bounces-59035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9766384F025
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447BD28B02B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7575731A;
	Fri,  9 Feb 2024 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GApjCz+E"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EFC57314
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707459427; cv=none; b=Ir+VxJ2OTeeDreSw0xKn0rHUWnulmHwdLbx6KIS0o9oBWQFscAldqBgg+sxzX6BehGIhJBWXpn6OXM8MafNKUN1Tip47F4EQ9vK3RQ43SMr5MDqc8qjFKNfDDWb7xzsqjkSD/u9c3iCqBIheQI0OBa6HjmrD3+vUO44IZZD35xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707459427; c=relaxed/simple;
	bh=RRziseC30oVWspl2b2b+/iYUDLMnmxd2RSAQXJ/yuT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7+iRCbakI4K6s5LZxh2z2Jjijso5G9KHxFZ6INx1oRaz5QpM+aA0SuliseZznXi/T24dwOCfKifT6NyHEXwovOB5/jcMRX2PWY2KGUD5+hwKyLDWd0Bq/zlLLgGi4yrDmOKdPgTK7T4KUHYvZHP0nDjClpxfrQqfRnv3qeM2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GApjCz+E; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e12f8506ccso279922a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 22:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707459425; x=1708064225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mECq5c3qme0rKQWiGm3svRPPGMQfkIOTZJf8yAIPlZ4=;
        b=GApjCz+EVvLi0PjmYKdhVA9Bs0jET3AU7YYW2eJb17PXHOPHp1JvPshNvnwPI5CWb+
         91n0RF/kjCFr7kw+Ny+Nba2UITyjA7bW7rROzJHethEk+fHwoS3fBruJuej8HcCj51EV
         EDh3bFrBOue+aLp5QrzAHlVon4UBMNH5sIZvKuRZMdy3apRUzQCxAD5keFeAjxinulbP
         8/fPXW7kx9TR0luP1h4dQaBawbQVQvTS6qUfQxHIE35J8Via5cfY667h//E+f6VDnk2u
         ng9GVUwNVjMdwezVlaW0TMa10JB7ScaeTyTSOnGB1yT/rVjUH7zx5OtgVd1dx3lyCcdB
         cX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707459425; x=1708064225;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mECq5c3qme0rKQWiGm3svRPPGMQfkIOTZJf8yAIPlZ4=;
        b=QnClOhB+Y6Ucc7WLK/kymV9VMKdJNMuGJwvffZbWkg6zma9moTR2humh2EhbxIwE4I
         2Mn+ZsFHt1sZ6nlkqaiVhgCKHdUNTqNmeoSmpDU9WVvefeRZaLWRRiqCSWjnBbzJLiOL
         RHXc4/uurdw8/op/KdOLPaX6VzBbrPGkCjzaQAWRVhDUvCmkte9GdKt/ddCIx1re03xg
         lotEbb3Z9TMH9l00amfZVwS2gkxeZ5jdzGlVA3OeljuuAQS0KZJmVRr2tFZ7OVaJycuq
         bnswKk8k/hhyrneqGPjw9IO0Zjibg+xR7G9bmZIggEAtQb1QUbMYEqL2VCM4gd/YTowZ
         lpoA==
X-Gm-Message-State: AOJu0Yx3jCc4ieQD2qCSfW3JM6CSPJBY2j5DMcZZ2L8fffq4meO8NHxk
	/6qgxGsCWBK74ZUn6EblCG1xFNLspMuzQnHCSE7vJhtLno6kEyE+gcvmifg/
X-Google-Smtp-Source: AGHT+IFZIjMwa0zInTQY5XdzpGtkjG0Gu0+r8ncB3llL31KJpWBCEskA+3zEc/gljauKPYBaIs2TiQ==
X-Received: by 2002:a9d:4e95:0:b0:6dd:db5a:d924 with SMTP id v21-20020a9d4e95000000b006dddb5ad924mr593295otk.1.1707459424876;
        Thu, 08 Feb 2024 22:17:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 23-20020a631357000000b005dc4829d0e1sm907328pgt.85.2024.02.08.22.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 22:17:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <91218892-d8df-47f1-99a0-6c4564c7bebe@roeck-us.net>
Date: Thu, 8 Feb 2024 22:17:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sporadic regmap unit test failure in raw_sync
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <dc5e573d-0979-4d7e-ab4a-de18a4711385@roeck-us.net>
 <ZcVRcH/D945GKWjG@finisterre.sirena.org.uk>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZcVRcH/D945GKWjG@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 14:10, Mark Brown wrote:
> On Thu, Feb 08, 2024 at 01:45:13PM -0800, Guenter Roeck wrote:
> 
>>      # raw_sync: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:1305
>>      Expected &hw_buf[6] != val, but
>>          &hw_buf[6] ==
>>           57  30
>>          val ==
>>           57  30
>>          not ok 4 rbtree-big
>>          ok 5 maple-little
>>          ok 6 maple-big
>>      # raw_sync: pass:5 fail:1 skip:0 total:6
>>      not ok 25 raw_sync
> 
>> This is with regmap: 'kunit: fix raw noinc write test wrapping'
>> applied on top of the upstream kernel (v6.8-rc3-47-g047371968ffc).
>> So far I have seen it only once, with the x86_64:q35 emulation in qemu.
> 
> I guess it's possible that we randomly generated the same value for the
> initial and modified values here?


I think the diffs below should fix the problem. Would that do, or do you
have a better idea ?

Thanks,
Guenter

---
diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 4eb18f5d3265..666ece18726f 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -1266,7 +1266,11 @@ static void raw_sync(struct kunit *test)

         hw_buf = (u16 *)data->vals;

-       get_random_bytes(&val, sizeof(val));
+       /* values in val[] must be different from those in hw_buf[] */
+       val[0] = ~hw_buf[2];
+       if (val[0] == hw_buf[6])
+               val[0]++
+       val[1] = ~hw_buf[3];

         /* Do a regular write and a raw write in cache only mode */
         regcache_cache_only(map, true);


