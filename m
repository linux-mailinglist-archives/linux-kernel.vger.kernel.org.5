Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17627C4D23
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbjJKIaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJKIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:30:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E14D9C;
        Wed, 11 Oct 2023 01:30:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so11081984a12.1;
        Wed, 11 Oct 2023 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697013004; x=1697617804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDT7A8icxhw8bdAXxISSLC37kpezMa0dIgpPSbbiAFU=;
        b=kV0FMPGg8G8OXN23Y4KoWY9SPSHBWlImdJPuXKPio3fZTLVi8qWl4uP4R7RSFPa3g5
         pt1+0ZOcITOdpNZRg5QI3y110HEXq3wFWIrITInsSa2H0OPniIS96JwVK3rD1J0ez1X2
         J1gFRkeTv9RHn1yPSwgLD19jM94EGaVbjjOnckoL64rxMR0UsZNErPe+bUhsFnUyaS3M
         TdWM3dW0vFwAyk2pIYjYJF+MeSw/EzLKcsVqDYByuaByCXzhaC2fSltmzG4wjoAhlwJH
         F8i4L1BzixcOoB7a0qUaX8JfAZCuQH7uwIxJkGCswOByvwbBGcm/trf/wZLutHuFIGzm
         UfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697013004; x=1697617804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDT7A8icxhw8bdAXxISSLC37kpezMa0dIgpPSbbiAFU=;
        b=HE/qFVLaYI8MTLAgpAQg3HTngi8GMrBUxSYmq0aj6SdnENprd7BN/VvjEboN546PRU
         Wrh9zrSLo9JFbqfz/2oPmzHmvMcB8IWkk+5yJLueJ/lBNUVkGSThxA3ojnBvJDGQfph7
         3+SHQhPf4GU6BXXXzns1cidxk0bo4Sdv7o8qfOHCwQVWj5wVV7V+0zmLjEDbp6OMP/jo
         e4Jl569EXSN4dMQHeM1GWSlOB1QZyU3fVdqhlMhtb+NxMYIbC+gtfWfTSX/TjMTUKEeA
         wRc++l2cGAg1w6X2srQ2yCSq0f36bweHTOQD+f6sabHHw4jxBMZV/VrAGX5bkVvy2TaP
         04dQ==
X-Gm-Message-State: AOJu0YynUJf9byeQ/XLWeB6C4o0BOrS5bLqgvdHnKC1+roVYeJZrGXrZ
        Ristr3NQ5FwiNCnWnHN8vyg=
X-Google-Smtp-Source: AGHT+IE47tjUWmivTn7+cC6WKPpXW3xBoBSyN5C7ZSwcZmbJxEr5aMe3n9GXXHKyBq9tHY5RX7wMmg==
X-Received: by 2002:a50:ee84:0:b0:531:2b0b:9b8 with SMTP id f4-20020a50ee84000000b005312b0b09b8mr19616250edr.7.1697013004247;
        Wed, 11 Oct 2023 01:30:04 -0700 (PDT)
Received: from [147.251.42.107] (laomedon.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id c26-20020a056402101a00b00533e915923asm8560549edu.49.2023.10.11.01.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 01:30:03 -0700 (PDT)
Message-ID: <acf5d5b5-b3d9-403d-ad57-a865774b260f@gmail.com>
Date:   Wed, 11 Oct 2023 10:30:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix regression in sed-opal for a saved key.
Content-Language: en-US
To:     axboe@kernel.dk
Cc:     jonathan.derrick@linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Kozina <okozina@redhat.com>,
        regressions@lists.linux.dev, gjoyce@linux.vnet.ibm.com,
        linux-block@vger.kernel.org
References: <20231003100209.380037-1-gmazyland@gmail.com>
 <5c4fbafb1daa45f2faf60c7d587cd23c53d9393c.camel@linux.vnet.ibm.com>
 <59535b4b-9f07-44c5-a7da-e6b2fc1c67bb@gmail.com>
 <53755a0fbd6318d4783078259f2d2f8ab5f2f0b7.camel@linux.vnet.ibm.com>
From:   Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <53755a0fbd6318d4783078259f2d2f8ab5f2f0b7.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 19:58, Greg Joyce wrote:
> On Thu, 2023-10-05 at 08:58 +0200, Milan Broz wrote:
>> On 10/4/23 22:54, Greg Joyce wrote:
>>> On Tue, 2023-10-03 at 12:02 +0200, Milan Broz wrote:
>>>> The commit 3bfeb61256643281ac4be5b8a57e9d9da3db4335
>>>> introduced the use of keyring for sed-opal.
>>>>
>>>> Unfortunately, there is also a possibility to save
>>>> the Opal key used in opal_lock_unlock().
>>>>
>>>> This patch switches the order of operation, so the cached
>>>> key is used instead of failure for opal_get_key.
>>>>
>>>> The problem was found by the cryptsetup Opal test recently
>>>> added to the cryptsetup tree.
>>>>
>>>> Fixes: 3bfeb6125664 ("block: sed-opal: keyring support for SED
>>>> keys")
>>>> Tested-by: Ondrej Kozina <okozina@redhat.com>
>>>> Signed-off-by: Milan Broz <gmazyland@gmail.com>
>>>> ---
>>>>    block/sed-opal.c | 7 +++----
>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/block/sed-opal.c b/block/sed-opal.c
>>>> index 6d7f25d1711b..04f38a3f5d95 100644
>>>> --- a/block/sed-opal.c
>>>> +++ b/block/sed-opal.c
>>>> @@ -2888,12 +2888,11 @@ static int opal_lock_unlock(struct
>>>> opal_dev
>>>> *dev,
>>>>    	if (lk_unlk->session.who > OPAL_USER9)
>>>>    		return -EINVAL;
>>>>
>>>> -	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
>>>> -	if (ret)
>>>> -		return ret;
>>>>    	mutex_lock(&dev->dev_lock);
>>>>    	opal_lock_check_for_saved_key(dev, lk_unlk);
>>>> -	ret = __opal_lock_unlock(dev, lk_unlk);
>>>> +	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
>>>> +	if (!ret)
>>>> +		ret = __opal_lock_unlock(dev, lk_unlk);
>>>
>>> This is relying on opal_get_key() returning 0 to decide if
>>> __opal_lock_unlock() is called. Is this really what you want? It
>>> seems
>>> that you would want to unlock if the key is a LUKS key, even if
>>> opal_get_key() returns non-zero.
>>
>> I think it is ok. That was logic introduced in your keyring patch
>> anyway.
>>
>> I just fixed that if key is cached (stored in OPAL struct), that key
>> is used
>> and subsequent opal_get_key() does nothing, returning 0.
>>
>> The story is here that both OPAL lock and unlock need key, while LUKS
>> logic never required key for lock (deactivation), so we rely on the
>> cached
>> OPAL key here. We do not need any key stored for unlocking (that is
>> always
>> decrypted from a keyslot)
>> (I think requiring key for locking range is a design mistake in OPAL
>> but
>> that's not relevant for now :-)
> 
> Okay, if the key is such that opal_get_key() always returns 0, then I
> agree there isn't an issue.


Jens, what's the status of this patch?

It is clear regression in 6.6 (I forgot to add regression list, fixed now.)

For reference, the original report and patch is here
#regzbot link: https://lore.kernel.org/linux-block/20231003100209.380037-1-gmazyland@gmail.com/
#regzbot ^introduced 3bfeb6125664

Thanks,
Milan
