Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2435E801D2A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjLBNyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBNyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:54:37 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FF7116;
        Sat,  2 Dec 2023 05:54:43 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-5c239897895so1003914a12.2;
        Sat, 02 Dec 2023 05:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701525283; x=1702130083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQOH7+u4hLSIClzOMDwlaWGqqeGohEqTdqEdf5joqgg=;
        b=bnX4pcZLjH0c/vRWKJau3lqSEGyCaig0Q3hfN3nagg/8kjjtVFm+RIN8uOmc7Y3efA
         WbUne0nGsYsiwB6an7sWaegHhLTPosGdihsdENYlU1UzFSWW7W8UCcciQx5KPWVKjYan
         U5VEeAPoFOICKvhjqbfnN1ywfsA1wbHODhnFTooYirsvZZ0MiveaAqtjkh3djzEYLFBe
         bs6Pcy1qTPhl7VcUrYK1ECwc12IdOmOb7sPOJKSEY1GOltvD5DVjmsc9QqBx3X2nTTUY
         1axWxuFa581oImCEl49FSeSzKaYyH7jbnHIWVm0mxVMHXVL5Yvi7UDclxeUxqdTuY0MT
         MF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701525283; x=1702130083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VQOH7+u4hLSIClzOMDwlaWGqqeGohEqTdqEdf5joqgg=;
        b=B0qlJbnkHNSbPhlJLx/0ojMNTdgVOCegcA16D8NEuuKliyNAI89UFclxfLTfws4+vA
         pHizNAXQYRZBYcpWJ++PL2lOS8armR5rmmKK5EBZUhYlZpgl6ARgT0dgdd9cv/r5ui0m
         /og+HXH7Sa1IghL6JlDlw6q/sX6eQETh7ySEhVYFg6/GoUhUZ6FIoyJwD6XG/ohZ1M5t
         XdeHTdZgIX/ZQCngiCcjikrVXNBFPplgbyf5bgzLYbHl5ICKXIabuFntzYR2O8qkqOjg
         iHEq1n/X9wX3cYkI3/yX9kTCmPhs2ivOTICXy+VnWxWH7LgmmoZieDEnDm8QXMy0fR9A
         1K6g==
X-Gm-Message-State: AOJu0YzRMnYAeh5TfeMBxrmJIGw24oCnqvHbI6AgNBF4T76LOjYkWnr4
        N7YYaQyTCWiqelbIaHDFOWc=
X-Google-Smtp-Source: AGHT+IEj2DG9Hm84ZVY6USHcVo81v0BBinW2Guovnk3wv+TBurcs2sIYSmNUS8OM+W5VOmg5jAXIzg==
X-Received: by 2002:a17:90a:8a87:b0:285:b67b:f435 with SMTP id x7-20020a17090a8a8700b00285b67bf435mr349463pjn.41.1701525283332;
        Sat, 02 Dec 2023 05:54:43 -0800 (PST)
Received: from [10.164.172.236] ([182.255.33.153])
        by smtp.gmail.com with ESMTPSA id gd10-20020a17090b0fca00b0028066f3c373sm6628990pjb.17.2023.12.02.05.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 05:54:43 -0800 (PST)
Message-ID: <4b43d22d-f50c-4cb1-85a1-6eab468304f4@gmail.com>
Date:   Sat, 2 Dec 2023 21:54:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate
 bitmap memory in backing_dev_store
To:     Jens Axboe <axboe@kernel.dk>, minchan@kernel.org,
        senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        lincheng.yang@transsion.com, jiajun.ling@transsion.com,
        ldys2014@foxmail.com, Dongyun Liu <dongyun.liu@transsion.com>
References: <20231130152047.200169-1-dongyun.liu@transsion.com>
 <feb0a163-c1d3-4087-96dc-f64d0dde235b@kernel.dk>
 <3af0752f-0534-43c4-913f-4d4df8c8501b@gmail.com>
 <b26ab8d0-c719-4bf6-b909-26f4c014574b@kernel.dk>
From:   Dongyun Liu <dongyun.liu3@gmail.com>
In-Reply-To: <b26ab8d0-c719-4bf6-b909-26f4c014574b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/1 22:19, Jens Axboe wrote:
> On 11/30/23 11:51 PM, Dongyun Liu wrote:
>>
>>
>> On 2023/11/30 23:37, Jens Axboe wrote:
>>> On 11/30/23 8:20 AM, Dongyun Liu wrote:
>>>> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
>>>> index d77d3664ca08..ee6c22c50e09 100644
>>>> --- a/drivers/block/zram/zram_drv.c
>>>> +++ b/drivers/block/zram/zram_drv.c
>>>> @@ -514,7 +514,7 @@ static ssize_t backing_dev_store(struct device *dev,
>>>>          nr_pages = i_size_read(inode) >> PAGE_SHIFT;
>>>>        bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
>>>> -    bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
>>>> +    bitmap = kmalloc(bitmap_sz, GFP_ATOMIC);
>>>>        if (!bitmap) {
>>>>            err = -ENOMEM;
>>>>            goto out;
>>>
>>> Outside of this moving from a zeroed alloc to one that does not, the
>>> change looks woefully incomplete. Why does this allocation need to be
>>> GFP_ATOMIC, and:
>>
>> By using GFP_ATOMIC, it indicates that the caller cannot reclaim or
>> sleep, although we can prevent the risk of  deadlock when acquiring
>> the zram->lock again in zram_bvec_write.
> 
> Yes, I am very much aware of how gfp allocation flags work and how why
> it's broken. It was a rhetorical question as to why you think you could
> get away with just fixing one of them.
> 
>>> 1) file_name = kmalloc(PATH_MAX, GFP_KERNEL); does not
>>
>> There is no zram->init_lock held here, so there is no need to use
>> GFP_ATOMIC.
> 
> True
> 
>>> 2) filp_open() -> getname_kernel() -> __getname() does not
>>> 3) filp_open() -> getname_kernel() does not
>>> 4) bdev_open_by_dev() does not
>>
>> Missing the use of GFP_ATOMIC.
> 
> Indeed!
> 
>>> IOW, you have a slew of GFP_KERNEL allocations in there, and you
>>> probably just patched the largest one. But the core issue remains.
>>>
>>> The whole handling of backing_dev_store() looks pretty broken.
>>>
>>
>> Indeed, this patch only solves the biggest problem and does not
>> fundamentally solve it, because there are many processes for holding
>> zram->init_lock before allocation memory in backing_dev_store that
>> need to be fully modified, and I did not consider it thoroughly.
>> Obviously, a larger and better patch is needed to eliminate this risk,
>> but it is currently not necessary.
> 
> You agree that it doesn't fix the issue, it just happens to fix the one
> that you hit. And then you jump to the conclusion that this is all
> that's needed to fix it. Ehm, confused?
> 

Hi, Jens, Maybe there's something wrong with my expression. You can 
think of it this way: I agree with you that it doesn't fix the issue.
