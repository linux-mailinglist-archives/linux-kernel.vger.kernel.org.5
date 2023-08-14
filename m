Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF25777BD41
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjHNPkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjHNPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ED310DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692027540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HnwxoJIvuHQj1oL9+UcRHhuzEVRGxsaQ3RBeYdqhfQs=;
        b=TG4xt7sC8vu57205jFsa9oKCarIpg8NxKRawbdvvOqQc9ZnGpi1nZfZreczSCKkzKCnXmb
        btXqi4XaH0mA+cEoA+Qdlsj5Au6kliSWvJeWkmp41QubrclsRL4NkSnG4gSik0NSNvoFCr
        XITM5OibbwvGmN8I6kSRHbKEfhCx9xc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-pIwqhlXUMXC-svtXIIL79A-1; Mon, 14 Aug 2023 11:38:59 -0400
X-MC-Unique: pIwqhlXUMXC-svtXIIL79A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe1cdf2024so27132625e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692027537; x=1692632337;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnwxoJIvuHQj1oL9+UcRHhuzEVRGxsaQ3RBeYdqhfQs=;
        b=Mb/jSRKG2ON2Bo8GuRKByVtv3F8/ItZW4g1N/WPPl6yTDHty0CIkF+ZgXY23SBQ2Fv
         NPJ5s6mOlBOrbfci9EbGKvgBgK8FF0wTWixIwmqEu6rIRlycyQGZKBO5qJI6LEbpW08z
         KbA1Ex5ilvXDp3FVdIvwu/amq4b2lxiW/3RREUZvDxw7YALst8HGf+6u9yZjZHmtfmiw
         D3Shy+B+VPtvAyeLjBalfg2MnAE2a/CtC0gnCFQLzXflRuhHRCaA+okRVmNmVqOx6rar
         HseQKEYGITuwDPKB59gEDwFeSPAst8VdkOak5jbDh/hDA0gJZ5WHDWf8JNIB3IpVI4zS
         WPdA==
X-Gm-Message-State: AOJu0YwQrifKFiUf63gTqqPmIZ1S3VkHT0YHQyLl9WlaZ0UNbhumXCEE
        KjVavYJIXRy5Ud3Ngea9iZi+W0JSNEyoTXwCRqFjnSg4LUAdWJEQhMdSz+XVJopxfhXyclLKU1p
        IIweYdlofyg+EQYwjZT1/5Y5J
X-Received: by 2002:a05:600c:280b:b0:3fe:16c8:65fa with SMTP id m11-20020a05600c280b00b003fe16c865famr7911849wmb.4.1692027537004;
        Mon, 14 Aug 2023 08:38:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/s89rYWw96D5Y9CHspefHKsQ/KB097bvh1//LXb4Ii6z1kIyZ9hzt0hF/9euH574UEfGTUQ==
X-Received: by 2002:a05:600c:280b:b0:3fe:16c8:65fa with SMTP id m11-20020a05600c280b00b003fe16c865famr7911834wmb.4.1692027536556;
        Mon, 14 Aug 2023 08:38:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:d900:2d94:8433:b532:3418? (p200300d82f2bd9002d948433b5323418.dip0.t-ipconnect.de. [2003:d8:2f2b:d900:2d94:8433:b532:3418])
        by smtp.gmail.com with ESMTPSA id l4-20020a1ced04000000b003fe61c33df5sm17737760wmh.3.2023.08.14.08.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 08:38:56 -0700 (PDT)
Message-ID: <93d50ca7-6c78-eee0-c4ca-8ca3dff2ccd3@redhat.com>
Date:   Mon, 14 Aug 2023 17:38:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, linux-mm@kvack.org, koct9i@gmail.com,
        oleg@redhat.com, dave@stgolabs.net
References: <20230813123333.1705833-1-mjguzik@gmail.com>
 <00dd353b-e5aa-69fb-6b52-cb59028ea90a@redhat.com>
 <CAGudoHHHyZJXkNfGjGyxqHDay3yAzCm97r6SOdiSLYao7q2Z7A@mail.gmail.com>
 <88f1f73e-9879-95f9-bbc4-339c43a5c2f1@redhat.com>
 <CAGudoHGvBEpotHW0t3cDp4487SqSvba6JAW9N6jWuUz=_K7ixA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] kernel/fork: stop playing lockless games for exe_file
 replacement
In-Reply-To: <CAGudoHGvBEpotHW0t3cDp4487SqSvba6JAW9N6jWuUz=_K7ixA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.23 10:54, Mateusz Guzik wrote:
> On 8/14/23, David Hildenbrand <david@redhat.com> wrote:
>> On 14.08.23 10:21, Mateusz Guzik wrote:
>>> On 8/14/23, David Hildenbrand <david@redhat.com> wrote:
>>>> On 13.08.23 14:33, Mateusz Guzik wrote:
>>>>> xchg originated in 6e399cd144d8 ("prctl: avoid using mmap_sem for
>>>>> exe_file serialization"). While the commit message does not explain
>>>>> *why* the change, clearly the intent was to use mmap_sem less in this
>>>>> codepath. I found the original submission [1] which ultimately claims
>>>>> it
>>>>> cleans things up.
>>>>
>>>> More details are apparently in v1 of that patch:
>>>>
>>>> https://lore.kernel.org/lkml/1424979417.10344.14.camel@stgolabs.net/
>>>>
>>>> Regarding your patch: adding more mmap_write_lock() where avoidable, I'm
>>>> not so sure.
>>>>
>>>
>>> But exe_file access is already synchronized with the semaphore and
>>> your own commit added a mmap_read_lock/mmap_read_unlock cycle after
>>> the xchg in question to accomodate this requirement.
>>
>> Yes, we want to handle concurrent fork() ("Don't race with dup_mmap()"),
>> thus mmap_read_lock.
>>
>>> Then mmap_write_lock around the replacement is the obvious thing to do.
>>
>> Apparently to you. :)
>>
>> mmap_write_lock will block more than fork. For example, concurrent page
>> faults (without new VMA locking), for no apparent reason to me.
>>
>>>
>>>> Your patch doesn't look (to me) like it is removing a lot of complexity.
>>>>
>>>
>>> The code in the current form makes the reader ask what prompts xchg +
>>> read-lock instead of mere write-locking.
>>>
>>> This is not a hot path either and afaics it can only cause contention
>>> if userspace is trying to abuse the interface to break the kernel,
>>> messing with a processs hard at work (which would be an extra argument
>>> to not play games on kernel side).
>>>
>>> That said, no, it does not remove "a lot of complexity". It does
>>> remove some though at no real downside that I can see.
>>>
>>> But then again, it is on people who insist on xchg to justify it.
>>
>> Changing it now needs good justification, why we would want to block any
>> concurrent MM activity. Maybe there is good justification.
>>
>> In any case, this commit would have to update the documentation of
>> replace_mm_exe_file, that spells out existing locking behavior.
>>
> 
> Perhaps it will help if I add that the prctl thingy always had a
> troubled relationship with locking.

Yes, it's not the first time that I looked at kernel/sys.c and wodnered 
why some of the toggles don't perform any locking.

> 
> Last time I looked at it was in 2016, where I found that it was doing
> down_read to update arg_start/arg_end and others while a consumer in
> procfs would read them and assert on their sanity. As only a read-lock
> was held, 2 threads could be used to transiently produce a bogus state
> as they race with their updates and trigger the BUG. See this commit
> (but also excuse weirdly bad english ;))
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ddf1d398e517e660207e2c807f76a90df543a217
> 
> Moreover check out the following in prctl_set_auxv:
> 
>          task_lock(current);
>          memcpy(mm->saved_auxv, user_auxv, len);
>          task_unlock(current);
> 
> any thread in the process can reach that codepath while sharing the
> same mm, thus this does not lock any updates. Not only that, but a
> duplicated memcpy onto the area in prctl_set_mm_map does not even take
> that lock and the code to read this does not take any locks.
> 
> [Code duplication and synchronization aside, additional points
> deducted for saved_auxv storing always-NULL pointers instead of adding
> them on reads.]
> 
> The above exhausts my willingness to argue about this change, I'm just
> a passerby. If it is NAKed, I'm dropping the subject.

As long as nobody cares about concurrent MM activity being restricted 
with your change (I suspect we don't care), we're good.

-- 
Cheers,

David / dhildenb

