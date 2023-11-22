Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDC67F3E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjKVG0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVG03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:26:29 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA0AB9;
        Tue, 21 Nov 2023 22:26:25 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-332c7d4a6a7so1713495f8f.2;
        Tue, 21 Nov 2023 22:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700634384; x=1701239184;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8UXXM9XsNdfqTY9fWi2gO/4uVBR4veDhKM7OdvDlfU=;
        b=GW0puSHmBBGZHRBEblMt95mGE2axsuAsRWktW7+uUUDdAf+c5hP7zxBlt+8KbMIG7Z
         LN6M0Q+Vrg2MG7sRuUX3kzE/nFIpUY1lRRujz1pslaWIQV5chAOTfqbPArL03V+OGESN
         zDyK/CqRR+r7RUGeRhYm+7YgpJomMAi4TxovYLihP6aCdIBLpamVl9GZhTT2af1pV6ma
         A7y8MQrQRY+p9yRBBGGQEm6RtoXX5+b2dGdLRLgYMiKRtQwMw16nd0UbRi75V2oGQVct
         Nbg46Zb3thAQkC6EM38hOJ+85q6918eLDpmVi/q+8zb9cPDtXfPrX1C4Ar+eGBBpMggb
         aXhQ==
X-Gm-Message-State: AOJu0YxsZTZ2GLLuXVedAWERJXjlUE0p+SYF2NobwCsizPgwLq6C0BZn
        p9RmzQhdE7kkM3oD7l2Duxo=
X-Google-Smtp-Source: AGHT+IFOwT201SguVNh37eWo5CL7l9+JjCP1VxJx9chGtI8ifLlxmGA3Y523msK1A2l4o5ENiICodg==
X-Received: by 2002:adf:d1c7:0:b0:32f:8024:64f1 with SMTP id b7-20020adfd1c7000000b0032f802464f1mr962845wrd.2.1700634383493;
        Tue, 21 Nov 2023 22:26:23 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d6389000000b00332cc3e0817sm5010371wru.39.2023.11.21.22.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 22:26:23 -0800 (PST)
Message-ID: <4e195719-fb7d-48b8-8d92-8905f47a92dd@kernel.org>
Date:   Wed, 22 Nov 2023 07:26:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] tty: srmcons: use 'count' directly in
 srmcons_do_write()
Content-Language: en-US
To:     Richard Henderson <richard.henderson@linaro.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
References: <20231121092258.9334-1-jirislaby@kernel.org>
 <20231121092258.9334-15-jirislaby@kernel.org>
 <4f0db52-6430-9122-1ecc-86e337644944@linux.intel.com>
 <f4babac1-8366-45a2-94c2-838cacb4a006@linaro.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <f4babac1-8366-45a2-94c2-838cacb4a006@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 11. 23, 18:48, Richard Henderson wrote:
> On 11/21/23 09:21, Ilpo Järvinen wrote:
>> On Tue, 21 Nov 2023, Jiri Slaby (SUSE) wrote:
>>
>>> Similarly to 'buf' in the previous patch, there is no need to have a
>>> separate counter ('remaining') in srmcons_do_write(). 'count' can be
>>> used directly which simplifies the code a bit.
>>>
>>> Note that the type of the current count ('c') is changed from 'long' to
>>> 'size_t' so that:
>>> 1) it is prepared for the upcoming change of 'count's type, and
>>> 2) is unsigned.
>>>
>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>> Cc: Richard Henderson <richard.henderson@linaro.org>
>>> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>>> Cc: Matt Turner <mattst88@gmail.com>
>>> Cc: linux-alpha@vger.kernel.org
>>> ---
>>>   arch/alpha/kernel/srmcons.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
>>> index b68c5af083cd..8025e2a882ed 100644
>>> --- a/arch/alpha/kernel/srmcons.c
>>> +++ b/arch/alpha/kernel/srmcons.c
>>> @@ -92,24 +92,24 @@ static int
>>>   srmcons_do_write(struct tty_port *port, const char *buf, int count)
>>>   {
>>>       static char str_cr[1] = "\r";
>>> -    long c, remaining = count;
>>> +    size_t c;
>>>       srmcons_result result;
>>>       int need_cr;
>>> -    while (remaining > 0) {
>>> +    while (count > 0) {
>>>           need_cr = 0;
>>>           /*
>>>            * Break it up into reasonable size chunks to allow a chance
>>>            * for input to get in
>>>            */
>>> -        for (c = 0; c < min_t(long, 128L, remaining) && !need_cr; c++)
>>> +        for (c = 0; c < min_t(size_t, 128U, count) && !need_cr; c++)
>>>               if (buf[c] == '\n')
>>>                   need_cr = 1;
>>>
>>>           while (c > 0) {
>>>               result.as_long = callback_puts(0, buf, c);
>>>               c -= result.bits.c;
>>> -            remaining -= result.bits.c;
>>> +            count -= result.bits.c;
>>>               buf += result.bits.c;
>>>               /*
>>>
>>
>> The patches in the series are in pretty odd order and it was not told
>> anywhere here that the return value is unused by the callers. I'd just
>> reorder the patches.
>>
> 
> Agreed, patch 15 needs to be before patch 14.  With that,

Ah, sure, I reordered the three to have buf and count changes close to 
each other, but didn't realize this.

thanks,
-- 
js
suse labs

