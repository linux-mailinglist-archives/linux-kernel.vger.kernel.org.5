Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925FE7B6F74
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbjJCRS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjJCRS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:18:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99778AC;
        Tue,  3 Oct 2023 10:18:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ad8a822508so218814766b.0;
        Tue, 03 Oct 2023 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696353504; x=1696958304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DR69r77jNGqyCUFfEWX0oQOxCdNx+7+uV9QErXJGao=;
        b=Fe9lIc4J5J0xqbXfjTsvNfqDgEGLiyua1aI3XdTAkPnn860g2Kc4NkdZ3MFb9NO5S6
         tvUcLsONCJfKnXifSVPyjtUwzknvD/Igf4/zgvW9XNVwuxVIU6QXidFBfCpH25yttmOU
         GQj7O4R4QVtZL4HMo3BDsoFAzQTwFtPzkOi8mSqDzQQ63tZp5IYgMZozRU5BiciQlvT9
         sIUWtX2EbWKUpUSUBmd82gRSP+lYzgyy7Ja5Dcn4d2vN6tUx/ijGBBpfhoof0d0nn9HF
         7ZovfESe5hPWhngCudpFWTtRhwTheYVdeSOgoEiFfALibiNiNLHJgMReq+maWVCoQMMX
         dOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696353504; x=1696958304;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DR69r77jNGqyCUFfEWX0oQOxCdNx+7+uV9QErXJGao=;
        b=nnoHi+5daz7yGynr/Tjb+zvZ1E639qUCpi2Z4pcKJ5N+vtYjnuGBqeYyYFHSN6QzBS
         ktiEF0jZCctaUV4KTqlxthPNVajbg9ambcNpMoWbCNCRWhXNXs/jObMW1l+Bku6vhiWY
         2Gq6luZcihbPpy6EXwvYwbQwvQRP0SdDohCZFv8W/EHjaPPeAI/uQjhXGSX2xttYEsHc
         uJrC3+4qSJWEfveRDrWND21JgN81QY3SJcWVf7aFTygEwUF3qrV2JzWZRTOVg0Bqq+DW
         SELeoKq1rgP24t4klV93qq8qcwpqTV0OE4077WxonUZkUpXsjW+q5vx1/71gDKJ5zhJf
         ufXA==
X-Gm-Message-State: AOJu0YyvSWr+UhGo5Geyob70Vs6NodvudT491EO/O+B4CJw9otEtYZi3
        Gnl5K1GuXaS7DgFc00krJaf4e9cc4no=
X-Google-Smtp-Source: AGHT+IEou8/vKABLVNviTnGbjABbqCX+m/ZAMPy7dXtGW1mdrYeT+Bq4axlJudGszRfIknYaY9BrBg==
X-Received: by 2002:a17:906:7383:b0:9ae:5aa5:ee6c with SMTP id f3-20020a170906738300b009ae5aa5ee6cmr15060319ejl.12.1696353503426;
        Tue, 03 Oct 2023 10:18:23 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.78.48])
        by smtp.gmail.com with ESMTPSA id k13-20020a05651c060d00b002bcb89e92dcsm315647lje.6.2023.10.03.10.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 10:18:22 -0700 (PDT)
Subject: Re: [PATCH 1/4] pata_parport: fix pata_parport_devchk
To:     Ondrej Zary <linux@zary.sk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230930191511.24994-1-linux@zary.sk>
 <20230930191511.24994-2-linux@zary.sk>
 <d040b3f7-4222-a027-34d0-5cf62aa63605@omp.ru>
 <202310031907.45632.linux@zary.sk>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <a3b4dc62-20f7-4900-b9db-87edc9131063@gmail.com>
Date:   Tue, 3 Oct 2023 20:18:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <202310031907.45632.linux@zary.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 8:07 PM, Ondrej Zary wrote:
[...]

>>> There's a 'x' missing in 0x55 in pata_parport_devchk(), causing the
>>> detection to always fail. Fix it.
>>>
>>> Signed-off-by: Ondrej Zary <linux@zary.sk>
>>
>>    I think we need a Fixes: tag here...
>>
>>> ---
>>>  drivers/ata/pata_parport/pata_parport.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
>>> index 1af64d435d3c..258d189f42e5 100644
>>> --- a/drivers/ata/pata_parport/pata_parport.c
>>> +++ b/drivers/ata/pata_parport/pata_parport.c
>>> @@ -64,7 +64,7 @@ static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
>>>  	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0xaa);
>>>  	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0x55);
>>>  
>>> -	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 055);
>>> +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0x55);
>>
>>    Oh, Gawd! How did this ever work?! :-/
>>    This bug seems to predate the Big PARIDE move...
> 
> This code was not present in PARIDE - it's my bug.

   Yes, I finally figured -- hence the Fixes: tag I suggested later....

> The function is a clone of ata_devchk() without direct port access.

   The libata's taskfile methods suck big time -- I even used to have
the plans to clean this stuff up at some point...

> It's called only from softreset so nobody notices the breakage until something goes wrong. The CD-865 drive needs a reset to start working.

   I thought the SRST reset is used at the initial detection phase as well...

MBR, Sergey
