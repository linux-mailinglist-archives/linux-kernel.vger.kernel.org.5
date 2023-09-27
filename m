Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1C77B034B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjI0Lqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjI0Lq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC1FC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695815142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvsPqdWL7XgWKeKWvC9F1HtbY+HpBNK3bs0TVz67ajA=;
        b=OMlKqdQi2jaRH2jeJPPuI4qslNen/zEYE32ku8Qgqt7U4qDmEd7vB0IoXJIrXsliC0wcfu
        vB4wiwIz9RVqjwuiX6fn5yIvTwoDSbz36hbxsyxI1uW9RL5h2z9fErfuMQnlCA9MBIKnBJ
        Qsbgx4mVFEKJShSIasWFUTa+DitmedM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-IC7uE5pjOEedGU-FskNxQw-1; Wed, 27 Sep 2023 07:45:40 -0400
X-MC-Unique: IC7uE5pjOEedGU-FskNxQw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c136b9d66aso146947111fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695815139; x=1696419939;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvsPqdWL7XgWKeKWvC9F1HtbY+HpBNK3bs0TVz67ajA=;
        b=n+QrAcLnMmb4h0pOqd9cJebFUsRf5+th1ZdGcc7h3QKCoUxAk2sQCOWKarltOenQWW
         5W+bL3utDr32doa7IryYN+hU0/OP60O5VZyzY4KGs5c1Pd4emcBx/F8FZnipKsA8aY9+
         Zl70NaLKTNbM607z85ipD/ZRrwedm9qF4MQMRo/BOzBYDjUFSHMxPZ7xVHmse5lxUDaA
         LX8nEWQB3BbiB77yRCsc5dSW5YL9ScH9Zi9AKGyxM4eT+Zupc+PC/2ImJtl8iOjWDU4s
         kjvwPeoVmWHltjBPyW9kQ0MzCOH78u8sRK6z1mza5v0O5C+r2Z0xFLzlizbhLYoqHazd
         Kq7A==
X-Gm-Message-State: AOJu0Yxg1ukz8jHy6PoM14/J/DNd4DTnss6f4cWU9ySLrMd951txyqrK
        n3/TEZXnCFA2UDyR2/0MTJmyBahIsU2+XntFbpOslr+DtPFjs0M9Df7P5NpSMw5fbnkBiwVFneF
        BqlUKShFcYaVpOO/XJED0RHoE
X-Received: by 2002:a05:6512:1287:b0:503:183c:1223 with SMTP id u7-20020a056512128700b00503183c1223mr2243225lfs.7.1695815139369;
        Wed, 27 Sep 2023 04:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMxjIWznnDjMe6Hk6VxuIsyF02/jJ80hi8lUi5oaXw4lt20x5rKCPRe8RS/GUfXlNVDxbElQ==
X-Received: by 2002:a05:6512:1287:b0:503:183c:1223 with SMTP id u7-20020a056512128700b00503183c1223mr2243209lfs.7.1695815139037;
        Wed, 27 Sep 2023 04:45:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id i13-20020a056402054d00b0052a063e52b8sm7930477edx.83.2023.09.27.04.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 04:45:38 -0700 (PDT)
Message-ID: <a050bc34-d98e-3d75-8c79-447dc7c913a1@redhat.com>
Date:   Wed, 27 Sep 2023 13:45:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next 1/3] drm/sched: implement dynamic job flow
 control
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Luben Tuikov <luben.tuikov@amd.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230924224555.15595-1-dakr@redhat.com>
 <312983ee-ba4c-477e-8846-072c815df862@amd.com>
 <12f19494-7fd0-055f-4135-e17581398eb5@redhat.com>
 <20230927092514.04776822@collabora.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230927092514.04776822@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/23 09:25, Boris Brezillon wrote:
> On Wed, 27 Sep 2023 02:13:59 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
> 
>> On 9/26/23 22:43, Luben Tuikov wrote:
>>> Hi,
>>>
>>> On 2023-09-24 18:43, Danilo Krummrich wrote:
>>>> Currently, job flow control is implemented simply by limiting the amount
>>>> of jobs in flight. Therefore, a scheduler is initialized with a
>>>> submission limit that corresponds to a certain amount of jobs.
>>>
>>> "certain"? How about this instead:
>>> " ... that corresponds to the number of jobs which can be sent
>>>     to the hardware."?
>>>    
>>>>
>>>> This implies that for each job drivers need to account for the maximum
>>>                                   ^,
>>> Please add a comma after "job".
>>>    
>>>> job size possible in order to not overflow the ring buffer.
>>>
>>> Well, different hardware designs would implement this differently.
>>> Ideally, you only want pointers into the ring buffer, and then
>>> the hardware consumes as much as it can. But this is a moot point
>>> and it's always a good idea to have a "job size" hint from the client.
>>> So this is a good patch.
>>>
>>> Ideally, you want to say that the hardware needs to be able to
>>> accommodate the number of jobs which can fit in the hardware
>>> queue times the largest job. This is a waste of resources
>>> however, and it is better to give a hint as to the size of a job,
>>> by the client. If the hardware can peek and understand dependencies,
>>> on top of knowing the "size of the job", it can be an extremely
>>> efficient scheduler.
>>>    
>>>>
>>>> However, there are drivers, such as Nouveau, where the job size has a
>>>> rather large range. For such drivers it can easily happen that job
>>>> submissions not even filling the ring by 1% can block subsequent
>>>> submissions, which, in the worst case, can lead to the ring run dry.
>>>>
>>>> In order to overcome this issue, allow for tracking the actual job size
>>>> instead of the amount job jobs. Therefore, add a field to track a job's
>>>
>>> "the amount job jobs." --> "the number of jobs."
>>
>> Yeah, I somehow manage to always get this wrong, which I guess you noticed
>> below already.
>>
>> That's all good points below - gonna address them.
>>
>> Did you see Boris' response regarding a separate callback in order to fetch
>> the job's submission units dynamically? Since this is needed by PowerVR, I'd
>> like to include this in V2. What's your take on that?
>>
>> My only concern with that would be that if I got what Boris was saying
>> correctly calling
>>
>> WARN_ON(s_job->submission_units > sched->submission_limit);
>>
>> from drm_sched_can_queue() wouldn't work anymore, since this could indeed happen
>> temporarily. I think this was also Christian's concern.
> 
> Actually, I think that's fine to account for the max job size in the
> first check, we're unlikely to have so many native fence waits that our
> job can't fit in an empty ring buffer.
> 

But it can happen, right? Hence, we can't have this check, do we?

