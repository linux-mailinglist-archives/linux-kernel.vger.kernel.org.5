Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FAD802516
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 16:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjLCOpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 09:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCOpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 09:45:44 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BECEEA;
        Sun,  3 Dec 2023 06:45:50 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-5c66988c2eeso548396a12.1;
        Sun, 03 Dec 2023 06:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701614750; x=1702219550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YPDtBol5mTdex48RDvw2MgClI62P90f/ucRE3RfG9E=;
        b=JxHULYRUbzFYxWRxScD0fQL11/EZ5SA5CzlhbgEBRJvuqEh5NtYd2ETyuVZqgs7Y1E
         P5oMUdkdxmGn/oitD6qBjWE2tFtBXHFH6SBeOffsJ4Mh6+cM4TcRxO5fC+YwO0DxkzYI
         xUhgIONamR6qUvDu19dpp0dycBdOoIQeF8ISn4TRNRy4FWKBWjboK6uOBT2yOUUh9k3w
         5VLCJgrKMwAmse96hxdA4/dd/05pa9HvKtMBjqzVnsYhUu0RhBKxxhGS2P+4w+H/UrG0
         OEywheMBjn/iSpAjCPswncyO+5nsJROvWzAgaOaZb02/9vNye5Ar10Wc+F1wsjsqkfgu
         dCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701614750; x=1702219550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7YPDtBol5mTdex48RDvw2MgClI62P90f/ucRE3RfG9E=;
        b=CpCS3DYlWlGRuHMRkYjQgeOEAVUioqPXAuIqbZ4pxzAaIi8KcPeCHHzHh38kZRHvKd
         rHyUQSBX73NEhf3Yo/yZeXR90TWUZlg2YTvmC0mUWpcNOf4jRlIq2oFGq+4uD2g6s6Pi
         H50jA9GOddbJwkICUVz0i5rjt1rq45WFrHgSy/uxZaBb40ehyjM1I0bYy+2WVpBq9zMZ
         4OWnZy635fVT3wUByfS6nHjImaXMTATNeTPetNEXdjeXitags0WyCqoRtjUP3Bs//8Nf
         coJ6ycsxeMPudkkBb/hG78J07A+CfTRrTCKwjFtAkuiNHxgBUXPp2gIxxHsnzhcP1hXa
         IVfw==
X-Gm-Message-State: AOJu0YzFEe4k/8cqC87UyYypp6IqCZHRlfSbokozJJpEKEuC9A4fRsZj
        tCS8iF+DbsmUaejmkXWsiVs=
X-Google-Smtp-Source: AGHT+IEJANqY4Xp8fAQVoeeyC1yFkErhk51ofEdkfAqyY1JOIOgTR3Hh9jyn2UczaD8zzD+f8lxVOA==
X-Received: by 2002:a17:90a:195d:b0:285:a118:3431 with SMTP id 29-20020a17090a195d00b00285a1183431mr3235429pjh.8.1701614749833;
        Sun, 03 Dec 2023 06:45:49 -0800 (PST)
Received: from [10.153.223.34] ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d3c600b001d082ed4670sm1734986plb.49.2023.12.03.06.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 06:45:49 -0800 (PST)
Message-ID: <90e0e6ca-da7c-44c4-b1be-3de19a887c5d@gmail.com>
Date:   Sun, 3 Dec 2023 22:45:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate
 bitmap memory in backing_dev_store
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     minchan@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, lincheng.yang@transsion.com,
        jiajun.ling@transsion.com, ldys2014@foxmail.com,
        Dongyun Liu <dongyun.liu@transsion.com>
References: <20231130152047.200169-1-dongyun.liu@transsion.com>
 <20231201153956.GB404241@google.com>
 <b49d6a29-e3a3-4b6b-8892-8ded319b2619@gmail.com>
 <20231203012326.GE404241@google.com>
From:   Dongyun Liu <dongyun.liu3@gmail.com>
In-Reply-To: <20231203012326.GE404241@google.com>
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



On 2023/12/3 9:23, Sergey Senozhatsky wrote:
> On (23/12/02 23:50), Dongyun Liu wrote:
>> On 2023/12/1 23:39, Sergey Senozhatsky wrote:
>>> On (23/11/30 23:20), Dongyun Liu wrote:
>>>> INFO: task init:331 blocked for more than 120 seconds.  "echo 0 >
>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>> task:init   state:D stack:    0 pid:    1 ppid:     0 flags:0x04000000
>>>> Call trace:
>>>>     __switch_to+0x244/0x4e4
>>>>     __schedule+0x5bc/0xc48
>>>>     schedule+0x80/0x164
>>>>     rwsem_down_read_slowpath+0x4fc/0xf9c
>>>>     __down_read+0x140/0x188
>>>>     down_read+0x14/0x24
>>>>     try_wakeup_wbd_thread+0x78/0x1ec [zram]
>>>>     __zram_bvec_write+0x720/0x878 [zram]
>>>>     zram_bvec_rw+0xa8/0x234 [zram]
>>>>     zram_submit_bio+0x16c/0x268 [zram]
>>>>     submit_bio_noacct+0x128/0x3c8
>>>>     submit_bio+0x1cc/0x3d0
>>>>     __swap_writepage+0x5c4/0xd4c
>>>>     swap_writepage+0x130/0x158
>>>>     pageout+0x1f4/0x478
>>>>     shrink_page_list+0x9b4/0x1eb8
>>>>     shrink_inactive_list+0x2f4/0xaa8
>>>>     shrink_lruvec+0x184/0x340
>>>>     shrink_node_memcgs+0x84/0x3a0
>>>>     shrink_node+0x2c4/0x6c4
>>>>     shrink_zones+0x16c/0x29c
>>>>     do_try_to_free_pages+0xe4/0x2b4
>>>>     try_to_free_pages+0x388/0x7b4
>>>>     __alloc_pages_direct_reclaim+0x88/0x278
>>>>     __alloc_pages_slowpath+0x4ec/0xf6c
>>>>     __alloc_pages_nodemask+0x1f4/0x3dc
>>>>     kmalloc_order+0x54/0x338
>>>>     kmalloc_order_trace+0x34/0x1bc
>>>>     __kmalloc+0x5e8/0x9c0
>>>>     kvmalloc_node+0xa8/0x264
>>>>     backing_dev_store+0x1a4/0x818 [zram]
>>>>     dev_attr_store+0x38/0x8c
>>>>     sysfs_kf_write+0x64/0xc4
>>>
>>> Hmm, I'm not really following this backtrace. Backing device
>>> configuration is only possible on un-initialized zram device.
>>> If it's uninitialized, then why is it being used for swapout
>>> later in the call stack?
>>
>> Uh, at this moment, zram has finished initializing and is
>> working. The backing device is an optional zram-based feature.
>> I think it can be created later.
> 
> backing_dev_store() can't be called on an initialized device,
> that's what init_done() at the very beginning of backing_dev_store()
> is supposed to ensure:
> 

We have modified the logic here to allow backing_dev_store() to be 
called multiple times. That's why the call trace comes in. On the other 
hand, I realized that I should show the upstream's call stack instead
of my custom feature next time. Thank you for your toleration.

> ...
> 	down_write(&zram->init_lock);
> 	if (init_done(zram)) {
> 		pr_info("Can't setup backing device for initialized device\n");
> 		err = -EBUSY;
> 		goto out;
> 	}
> ...
