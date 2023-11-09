Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B027E7282
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345118AbjKIT4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjKIT4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:56:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C4D3C25
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699559748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=449SuGePvATjn5tp4HyLcKrMf3SZiN0UHIQUcLzqf1M=;
        b=Bb5vzacC4glpCwpIvGANyNZN4OyEwKCr0in5nQJ93tqIsvaNnDZudZrdh2nDFvczTkqcGR
        m6JqKU2MfnRwJQThOczDeBwr/JKepes8DMQO8jBrbOPanh5V2IcLBV6JJiidIch0D8MfE3
        AE1i+7zHWGZAjbRGWo4r8u0I4EhRvAo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-ZiM1rVQvMsm6KRg5wbFT7g-1; Thu, 09 Nov 2023 14:55:47 -0500
X-MC-Unique: ZiM1rVQvMsm6KRg5wbFT7g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4084163ecd9so8599085e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 11:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699559746; x=1700164546;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=449SuGePvATjn5tp4HyLcKrMf3SZiN0UHIQUcLzqf1M=;
        b=kOyOvoxa9oJwl151l5/eKk4/KFkD/8Bvy3AG4VP4uJH0nopsJC6z3Osy02jtlSDX56
         oafkvMgFBpPKpZjgeTntETk/Mm6mCrxjzXgVDXMKIGJFlS01PIHV5zQkTRdOSMgzVHAY
         uTXiaS8Ikn/P1xG7w03AEo8YH5m5EsloXfiO/MDW8n3ud/C7wm0b5d99+nu4JTTcjna/
         VhDvUYf8y7Gkp7cQtbpzERoE+fztrfstV+RGMBSFPPOTmaBsT3xYwlj/xqPXLutaAXb1
         mY8NF1v0o80tC6XlnhFq036mfNQ0VsQNxi1q1SEWTiSykrJS+9vv+pV+cyOclD2R7WcX
         QD1Q==
X-Gm-Message-State: AOJu0YyiEuR99mK0l5cJsQEbiDAOiIsTKSQQWMKMtq/AOpvDlJy1bJE8
        DxXITYjm/MOzRNHqy18Y7Oz4i+3FcDuuOxZULzhgklE0D0vQLo6+L+n7rMOkMmQbIh/BBT2mcqh
        v3mU0eTpYDssV3AwTNUv9s2lI
X-Received: by 2002:a05:600c:68a:b0:408:4475:8cc1 with SMTP id a10-20020a05600c068a00b0040844758cc1mr5397602wmn.35.1699559745984;
        Thu, 09 Nov 2023 11:55:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4NKG5wB0gJEbcmArHRa0/4XU4inkMLfBR3udGHiHduQub1uThCHjG5THdPgesq8DE9mXvWQ==
X-Received: by 2002:a05:600c:68a:b0:408:4475:8cc1 with SMTP id a10-20020a05600c068a00b0040844758cc1mr5397593wmn.35.1699559745564;
        Thu, 09 Nov 2023 11:55:45 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c359600b004080f0376a0sm3043990wmq.42.2023.11.09.11.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 11:55:45 -0800 (PST)
Message-ID: <c2c4a1e3-9a8c-4922-aecc-8894d13a8054@redhat.com>
Date:   Thu, 9 Nov 2023 20:55:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: fix potential page fault in
 drm_sched_job_init()
Content-Language: en-US
From:   Danilo Krummrich <dakr@redhat.com>
To:     Luben Tuikov <ltuikov89@gmail.com>, airlied@gmail.com,
        daniel@ffwll.ch, christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231108022716.15250-1-dakr@redhat.com>
 <fff7a8db-be77-4c5e-a4dd-82b254adbb78@gmail.com>
 <242188d1-2232-4e37-8ad7-f2cdebacddd9@redhat.com>
Organization: RedHat
In-Reply-To: <242188d1-2232-4e37-8ad7-f2cdebacddd9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/23 01:09, Danilo Krummrich wrote:
> On 11/8/23 06:46, Luben Tuikov wrote:
>> Hi,
>>
>> Could you please use my gmail address, the one one I'm responding from--I don't want
>> to miss any DRM scheduler patches. BTW, the luben.tuikov@amd.com email should bounce
>> as undeliverable.
>>
>> On 2023-11-07 21:26, Danilo Krummrich wrote:
>>> Commit 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable
>>> number of run-queues") introduces drm_err() in drm_sched_job_init(), in
>>> order to indicate that the given entity has no runq, however at this
>>> time job->sched is not yet set, likely to be NULL initialized, and hence
>>> shouldn't be used.
>>>
>>> Replace the corresponding drm_err() call with pr_err() to avoid a
>>> potential page fault.
>>>
>>> While at it, extend the documentation of drm_sched_job_init() to
>>> indicate that job->sched is not a valid pointer until
>>> drm_sched_job_arm() has been called.
>>>
>>> Fixes: 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable number of run-queues")
>>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>>> ---
>>>   drivers/gpu/drm/scheduler/sched_main.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>>> index 27843e37d9b7..dd28389f0ddd 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>> @@ -680,6 +680,9 @@ EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>>>    * This function returns -ENOENT in this case (which probably should be -EIO as
>>>    * a more meanigful return value).
>>>    *
>>> + * Note that job->sched is not a valid pointer until drm_sched_job_arm() has
>>> + * been called.
>>> + *
>>
>> Good catch!
>>
>> Did you actually get this to page-fault and have a kernel log?
> 
> No, I just found it because I was about to make the same mistake.
> 
>>
>> I'm asking because we see it correctly set in this kernel log coming from AMD,
> 
> I think that's because amdgpu just sets job->sched to *some* scheduler instance after
> job allocation [1].
> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c#L108
> 
>>
>> [   11.886024] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_init: entity has no rq!
>>
>> in this email,
>> https://lore.kernel.org/r/CADnq5_PS64jYS_Y3kGW27m-kuWP+FQFiaVcOaZiB=JLSgPnXBQ@mail.gmail.com
>>
>>>    * Returns 0 for success, negative error code otherwise.
>>>    */
>>>   int drm_sched_job_init(struct drm_sched_job *job,
>>> @@ -691,7 +694,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
>>>            * or worse--a blank screen--leave a trail in the
>>>            * logs, so this can be debugged easier.
>>>            */
>>> -        drm_err(job->sched, "%s: entity has no rq!\n", __func__);
>>> +        pr_err("%s: entity has no rq!\n", __func__);
>>
>> Is it feasible to do something like the following?
>>
>>         dev_err(job->sched ? job->sched->dev : NULL, "%s: entity has no rq!\n", __func__);
> 
> I don't think that's a good idea. Although I'd assume that every driver zero-initializes its job
> structures, I can't see a rule enforcing that. Hence, job->sched can be a random value until
> drm_sched_job_arm() is called.
> 
> However, I notice there are quite a view more fields of struct drm_sched_job that are never
> initialized, hence there are either a couple more potential bugs or missing documentation that
> drivers *must* ensure that a job is zero-initialized.

Any opinions on that? Otherwise I'd probably go ahead and send a fix for the other bugs too.

> 
> Not quite sure if we really want to rely on the latter for core infrastructure...
> 
>>
>>>           return -ENOENT;
>>>       }
>>>
>>> base-commit: c015fb6d01adb616fb54824feb55ce5ab18e8ca1
>>

