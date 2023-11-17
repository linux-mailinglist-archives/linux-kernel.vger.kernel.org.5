Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B177EF55A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjKQPhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQPhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:37:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EA8127
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700235454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=8EWZd8/Ob3Ap8d2DySNgwA5XTVgiADnOXvREM+zk/Tc=;
        b=Rqyjlt6gOEP299v2/O/6e9sokls6AHMPr2okUtl+adTpOAjjCcl29TphrJtZ2f995C4OvF
        f+ByRgMxOro3W1kP+5zmEbnXYc6w2tQiJYyIyV0n6w4d9TDpVeZcYwdDIFUnqoNd0DvjZo
        uaO/qKWhtrR2sSFH6F8qaRWkyKv5x1Y=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-IGK8eUHdPHK31Fj4UAsdMA-1; Fri, 17 Nov 2023 10:37:33 -0500
X-MC-Unique: IGK8eUHdPHK31Fj4UAsdMA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c5194d4e98so19274011fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700235451; x=1700840251;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EWZd8/Ob3Ap8d2DySNgwA5XTVgiADnOXvREM+zk/Tc=;
        b=ENerMBZAXHsM9VsYicMhV1d5vNUNmOkxF+MQtgqHUOKZ6d2WMSCVEFLOyKjtaCNhn1
         KaV8576WTm8Al/S/KwdJMN73rm83UPcPoZq4Zqepw4gBU9qG1r2vovAzb0ivgGHvy3H1
         P6m+3LkDbBUBbPP2d7VGeGBM4dHOH0QEdchzXVAj1q499OXMxZWqidLaO7mbKPjtfEiP
         pPnCMPeSfjnwswnRwXcbWqTmIFjV+y1/wxcoVoAncy8GaF1aMrvNdS1nWsbcsC2vFmrD
         XxHaYwrlu0Dt6Cv+uTRhp2wUPJvBfHz5g7SCeS+1YkZs+JJyx9grcqUquDwP1ecHEd07
         OWGQ==
X-Gm-Message-State: AOJu0YxqQ+S5dc3GketIgQdl8uacIoVgDBCOFXTE5ziYGBp2XjQP0RSN
        L1c5dCFqSJ7Gwms8PZAR9dPvpsF03MWDHthuibgcoN28knb82LGENyzJSJPn0bzJzluI1xFo8Yl
        dcqPCWYrO7MkNv5FFQY/FX4Zu9L/pCHtS
X-Received: by 2002:a2e:5455:0:b0:2c5:1623:66ab with SMTP id y21-20020a2e5455000000b002c5162366abmr8206301ljd.1.1700235451284;
        Fri, 17 Nov 2023 07:37:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKFYYuc+FIIjLuEND1GIJmf5cGTmSitK3FY9FWeIgeL8mmHO0hNCAQMqKGu8hnC9pgd6b/1A==
X-Received: by 2002:a2e:5455:0:b0:2c5:1623:66ab with SMTP id y21-20020a2e5455000000b002c5162366abmr8206288ljd.1.1700235450813;
        Fri, 17 Nov 2023 07:37:30 -0800 (PST)
Received: from [192.168.3.108] (p4ff23170.dip0.t-ipconnect.de. [79.242.49.112])
        by smtp.gmail.com with ESMTPSA id z16-20020a05600c221000b0040472ad9a3dsm3084684wml.14.2023.11.17.07.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 07:37:30 -0800 (PST)
Message-ID: <ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com>
Date:   Fri, 17 Nov 2023 16:37:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] implement "memmap on memory" feature on s390
Content-Language: en-US
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <ec3fcd7d-17a0-4901-9261-a204c2c50c52@redhat.com>
 <20231117140009.5d8a509c@thinkpad-T15>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231117140009.5d8a509c@thinkpad-T15>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.23 14:00, Gerald Schaefer wrote:
> On Fri, 17 Nov 2023 00:08:31 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 14.11.23 19:02, Sumanth Korikkar wrote:
>>> Hi All,
>>>
>>> The patch series implements "memmap on memory" feature on s390 and
>>> provides the necessary fixes for it.
>>
>> Thinking about this, one thing that makes s390x different from all the
>> other architectures in this series is the altmap handling.
>>
>> I'm curious, why is that even required?
>>
>> A memmep that is not marked as online in the section should not be
>> touched by anybody (except memory onlining code :) ). And if we do, it's
>> usually a BUG because that memmap might contain garbage/be poisoned or
>> completely stale, so we might want to track that down and fix it in any
>> case.
>>
>> So what speaks against just leaving add_memory() populate the memmap
>> from the altmap? Then, also the page tables for the memmap are already
>> in place when onlining memory.
> 
> Good question, I am not 100% sure if we ran into bugs, or simply assumed
> that it is not OK to call __add_pages() when the memory for the altmap
> is not accessible.

I mean, we create the direct map even though nobody should access that 
memory, so maybe we can simply map the altmap even though nobody should 
should access that memory.

As I said, then, even the page tables for the altmap are allocated 
already and memory onlining likely doesn't need any allocation anymore 
(except, there is kasan or some other memory notifiers have special 
demands).

Certainly simpler :)

> 
> Maybe there is also already a common code bug with that, s390 might be
> special but that is often also good for finding bugs in common code ...

If it's only the page_init_poison() as noted by Sumanth, we could 
disable that on s390x with an altmap some way or the other; should be 
possible.

I mean, you effectively have your own poisoning if the altmap is 
effectively inaccessible and makes your CPU angry on access :)

Last but not least, support for an inaccessible altmap might come in 
handy for virtio-mem eventually, and make altmap support eventually 
simpler. So added bonus points.

> 
>> Then, adding two new notifier calls on start of memory_block_online()
>> called something like MEM_PREPARE_ONLINE and end the end of
>> memory_block_offline() called something like MEM_FINISH_OFFLINE is still
>> suboptimal, but that's where standby memory could be
>> activated/deactivated, without messing with the altmap.
>>
>> That way, the only s390x specific thing is that the memmap that should
>> not be touched by anybody is actually inaccessible, and you'd
>> activate/deactivate simply from the new notifier calls just the way we
>> used to do.
>>
>> It's still all worse than just adding/removing memory properly, using a
>> proper interface -- where you could alloc/free an actual memmap when the
>> altmap is not desired. But I know that people don't want to spend time
>> just doing it cleanly from scratch.
> 
> Yes, sometimes they need to be forced to do that :-)

I certainly won't force you if we can just keep the __add_pages() calls 
as is; having an altmap that is inaccessible but fully prepared sounds 
reasonable to me.

I can see how this gives an immediate benefit to existing s390x 
installations without being too hacky and without taking a long time to 
settle.

But I'll strongly suggest to evaluate a new interface long-term.

> 
> So, we'll look into defining a "proper interface", and treat patches 1-3
> separately as bug fixes? Especially patch 3 might be interesting for arm,
> if they do not have ZONE_DEVICE, but still use the functions, they might
> end up with the no-op version, not really freeing any memory.

It might make sense to

1) Send the first 3 out separately
2) Look into a simple variant that leaves __add_pages() calls alone and
    only adds the new MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers --
    well, and deals with an inaccessible altmap, like the
    page_init_poison() when the altmap might be inaccessible.
3) Look into a proper interface to add/remove memory instead of relying
    on online/offline.

2) is certainly an improvement and might be desired in some cases. 3) is 
more powerful (e.g., where you don't want an altmap because of 
fragmentation) and future proof.

I suspect there will be installations where an altmap is undesired: it 
fragments your address space with unmovable (memmap) allocations. 
Currently, runtime allocations of gigantic pages are affected. Long-term 
other large allocations (if we ever see very large THP) will be affected.

For that reason, we want to either support variable-sized memory blocks 
long-term, or simulate that by "grouping" memory blocks that share a 
same altmap located on the first memory blocks in that group: but 
onlining one block forces onlining of the whole group.

On s390x that adds all memory ahead of time, it's hard to make a 
decision what the right granularity will be, and seeing sudden 
online/offline changed behavior might be quite "surprising" for users. 
The user can give better hints when adding/removing memory explicitly.

-- 
Cheers,

David / dhildenb

