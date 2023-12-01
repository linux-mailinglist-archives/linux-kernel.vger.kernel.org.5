Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7967380042A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377658AbjLAGvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjLAGvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:51:35 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351E1171B;
        Thu, 30 Nov 2023 22:51:42 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id 006d021491bc7-58cf894544cso992315eaf.3;
        Thu, 30 Nov 2023 22:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701413501; x=1702018301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jmob8Yu3ll9DCzld16GfmggolTJuN4mewUYzS+X43o=;
        b=aHwUUq/a2vta3nlepR6XOLQBWsv09y+WzIBvzreAlNNXVasqLc803q74ZyNPPLWWkY
         yBkhhzQt3BCiOF/2eJIDx8jWobvokdn6mb0Z1tVMIygcXyXibeDyjbLaerwlw2tUEKmr
         kUm/87VgPWhBy+b2fIll9n7wpyfeO2JPXx3teJ9lcJHIwZmZE5p8fZBamz4ujurf6EqD
         yYLqQmb/wWhFyIDHstud70ZHmOS1XTXeCpmRmQC6/2UuXmFVEmgMTcWPm0jXCF/IbqXE
         AU6k3TltZo1cBumVaJ2gT2PCtMmkI1K73Hg6DAdU9FVZeNdwnxG+0eJLPPjdv9sXWLWM
         B6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701413501; x=1702018301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5jmob8Yu3ll9DCzld16GfmggolTJuN4mewUYzS+X43o=;
        b=OF7JhqKj4kVm/n7610KUbWitUynbvFBFX4eZjcpDYy8trGpkNEwceccuklSATzRBeE
         SdtPAMjX8gsg/OHsLI4hSegkbH43FrP3JONnYL7iasnFHj8bE6ZxE+iW54kOzUPM/2Hd
         Ajyfd+kp7Vlqb4T1Oqs5J6OqYnUo+nUvfRoLbjsVgxM35zJdsryPgN6pdJHH7X4BdtN8
         48ZI8i9rYfWYwSSCoOt0/fcHE9j3/UoQjr2UZjibxBNgV/KFtpit6J+kRRT6Af9Z3RC2
         aMupC4Cuz6OXrkB3uOqt1wt2xWcgcOPC3v69ctZhXU0U67ZSVlxxA+mUFWVbeO0zb1H9
         9iow==
X-Gm-Message-State: AOJu0YxlJszCyoaZZPPBNiIbDI7O0uu838jbj8iOpw4hvMCekBfkVuPw
        RYE8NP7SEB3RLxF2CpLbtMY=
X-Google-Smtp-Source: AGHT+IGXnJn92DPfn/23tvUdSM36vhr5UHs+tjR58VeaUP7vdyCL9XNbonyWSW4j/THC1/OCjPwD1g==
X-Received: by 2002:a05:6359:150a:b0:170:73d:fce9 with SMTP id jt10-20020a056359150a00b00170073dfce9mr2478497rwb.16.1701413501306;
        Thu, 30 Nov 2023 22:51:41 -0800 (PST)
Received: from [10.153.223.34] ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id i19-20020a63e453000000b005c1ce3c960bsm2328771pgk.50.2023.11.30.22.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 22:51:41 -0800 (PST)
Message-ID: <3af0752f-0534-43c4-913f-4d4df8c8501b@gmail.com>
Date:   Fri, 1 Dec 2023 14:51:36 +0800
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
From:   Dongyun Liu <dongyun.liu3@gmail.com>
In-Reply-To: <feb0a163-c1d3-4087-96dc-f64d0dde235b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/30 23:37, Jens Axboe wrote:
> On 11/30/23 8:20 AM, Dongyun Liu wrote:
>> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
>> index d77d3664ca08..ee6c22c50e09 100644
>> --- a/drivers/block/zram/zram_drv.c
>> +++ b/drivers/block/zram/zram_drv.c
>> @@ -514,7 +514,7 @@ static ssize_t backing_dev_store(struct device *dev,
>>   
>>   	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
>>   	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
>> -	bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
>> +	bitmap = kmalloc(bitmap_sz, GFP_ATOMIC);
>>   	if (!bitmap) {
>>   		err = -ENOMEM;
>>   		goto out;
> 
> Outside of this moving from a zeroed alloc to one that does not, the
> change looks woefully incomplete. Why does this allocation need to be
> GFP_ATOMIC, and:

By using GFP_ATOMIC, it indicates that the caller cannot reclaim or 
sleep, although we can prevent the risk of  deadlock when acquiring the 
zram->lock again in zram_bvec_write.

> 
> 1) file_name = kmalloc(PATH_MAX, GFP_KERNEL); does not

There is no zram->init_lock held here, so there is no need to use
GFP_ATOMIC.

> 2) filp_open() -> getname_kernel() -> __getname() does not
> 3) filp_open() -> getname_kernel() does not
> 4) bdev_open_by_dev() does not

Missing the use of GFP_ATOMIC.

> 
> IOW, you have a slew of GFP_KERNEL allocations in there, and you
> probably just patched the largest one. But the core issue remains.
> 
> The whole handling of backing_dev_store() looks pretty broken.
> 

Indeed, this patch only solves the biggest problem and does not
fundamentally solve it, because there are many processes for holding
zram->init_lock before allocation memory in backing_dev_store that need
to be fully modified, and I did not consider it thoroughly. Obviously,
a larger and better patch is needed to eliminate this risk, but it is 
currently not necessary.

Thank you for your kind and patient.
