Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AE37E71FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbjKITK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345096AbjKITKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:10:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750123C26
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699556976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ZS+ED1OtV7jojhpooYSza/QLYPRRicMYxwVIrlFhEc=;
        b=Jw6GaiFRP84D3MdL9pPzeYbQQ55bybop0kBwlDGBIJ87g2F6fDr/Ooxnlr5+PGrh6yNao1
        NQ1BfZli9V/32JWbRJG0umhzO8lebz/zkbC5qaz1rBYiFHQJW+k9EURfEgyGOzfweNIjN2
        +WBOJxi88uRsSeVFJgZoWQpTKyVY9DE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-V8g9hX5SOLuHy68xi6dMGg-1; Thu, 09 Nov 2023 14:09:34 -0500
X-MC-Unique: V8g9hX5SOLuHy68xi6dMGg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c503af866dso12296031fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 11:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556972; x=1700161772;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZS+ED1OtV7jojhpooYSza/QLYPRRicMYxwVIrlFhEc=;
        b=QxYYrK+5156GSXO7craj2hzwnlt8ViNKBdR0lV0zMMkbOqHQ2QSUWLl0E+yPYu0o4s
         vkB+TDM8BPEslVfaNXHZ0pDg390DPIuRUhMIW8lCqVVnm8CIqwU9ouqLTBpcTEap9ZXj
         ZQ+pDbeu43oHU3cjej8mNEzaC2M+BGO1ZINrqLVcHXp9AuxT4C+IiBin8LKkcaHLmSnC
         owzFkBE8272QRZ8djLGucw4PWnE1xUlAN9Zo/us/s0z8NR0n7owv9XywUSpw4WgCH0hD
         wLNm2ZaIX2DdKQAkPt8tHdos8e0lFmUHT9CRa5XuK/qEkeYvHCXNc7lMB9udKy+7Aiwo
         kW7w==
X-Gm-Message-State: AOJu0Yyaz2O/teM3MJ/Aq+L3kO4SvaTU0lNiyx9pnol6/PXdlEzqFIpi
        HGtkqdRbWqNRY7Ni+7B2jHNsKXtIDg2Ovew0tovhcv1hpZ+DAbuw+Vhr0AWD0GHQE29yfUxuMUI
        Ov/OMiCjHIW/2bEnN+BpFpkrQ
X-Received: by 2002:a05:651c:198c:b0:2c7:f55:eb61 with SMTP id bx12-20020a05651c198c00b002c70f55eb61mr5890363ljb.6.1699556972724;
        Thu, 09 Nov 2023 11:09:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJB7bAWkQ9HmCg37l+NjNNrOqdgAwf1ZCoNz0tmnIi7/Y87j6+eGNa72dXpiUB31g87oqFFg==
X-Received: by 2002:a05:651c:198c:b0:2c7:f55:eb61 with SMTP id bx12-20020a05651c198c00b002c70f55eb61mr5890340ljb.6.1699556972326;
        Thu, 09 Nov 2023 11:09:32 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id v29-20020adfa1dd000000b0032dab20e773sm298621wrv.69.2023.11.09.11.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 11:09:31 -0800 (PST)
Message-ID: <96200931-fb3f-40a2-8c0d-5a3609c11207@redhat.com>
Date:   Thu, 9 Nov 2023 20:09:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: fix potential page fault in
 drm_sched_job_init()
Content-Language: en-US
To:     Luben Tuikov <ltuikov89@gmail.com>, airlied@gmail.com,
        daniel@ffwll.ch, christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231108022716.15250-1-dakr@redhat.com>
 <fff7a8db-be77-4c5e-a4dd-82b254adbb78@gmail.com>
 <242188d1-2232-4e37-8ad7-f2cdebacddd9@redhat.com>
 <4c64c9f2-78b4-4309-8cca-5dbd0e5b445e@gmail.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <4c64c9f2-78b4-4309-8cca-5dbd0e5b445e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/23 05:23, Luben Tuikov wrote:
> On 2023-11-08 19:09, Danilo Krummrich wrote:
>> On 11/8/23 06:46, Luben Tuikov wrote:
>>> Hi,
>>>
>>> Could you please use my gmail address, the one one I'm responding from--I don't want
>>> to miss any DRM scheduler patches. BTW, the luben.tuikov@amd.com email should bounce
>>> as undeliverable.
>>>
>>> On 2023-11-07 21:26, Danilo Krummrich wrote:
>>>> Commit 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable
>>>> number of run-queues") introduces drm_err() in drm_sched_job_init(), in
>>>> order to indicate that the given entity has no runq, however at this
>>>> time job->sched is not yet set, likely to be NULL initialized, and hence
>>>> shouldn't be used.
>>>>
>>>> Replace the corresponding drm_err() call with pr_err() to avoid a
>>>> potential page fault.
>>>>
>>>> While at it, extend the documentation of drm_sched_job_init() to
>>>> indicate that job->sched is not a valid pointer until
>>>> drm_sched_job_arm() has been called.
>>>>
>>>> Fixes: 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable number of run-queues")
>>>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>>>> ---
>>>>    drivers/gpu/drm/scheduler/sched_main.c | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>>>> index 27843e37d9b7..dd28389f0ddd 100644
>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>> @@ -680,6 +680,9 @@ EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>>>>     * This function returns -ENOENT in this case (which probably should be -EIO as
>>>>     * a more meanigful return value).
>>>>     *
>>>> + * Note that job->sched is not a valid pointer until drm_sched_job_arm() has
>>>> + * been called.
>>>> + *
>>>
>>> Good catch!
>>>
>>> Did you actually get this to page-fault and have a kernel log?
>>
>> No, I just found it because I was about to make the same mistake.
>>
>>>
>>> I'm asking because we see it correctly set in this kernel log coming from AMD,
>>
>> I think that's because amdgpu just sets job->sched to *some* scheduler instance after
>> job allocation [1].
>>
>> [1] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c#L108
>>
>>>
>>> [   11.886024] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_init: entity has no rq!
>>>
>>> in this email,
>>> https://lore.kernel.org/r/CADnq5_PS64jYS_Y3kGW27m-kuWP+FQFiaVcOaZiB=JLSgPnXBQ@mail.gmail.com
>>>
>>>>     * Returns 0 for success, negative error code otherwise.
>>>>     */
>>>>    int drm_sched_job_init(struct drm_sched_job *job,
>>>> @@ -691,7 +694,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
>>>>    		 * or worse--a blank screen--leave a trail in the
>>>>    		 * logs, so this can be debugged easier.
>>>>    		 */
>>>> -		drm_err(job->sched, "%s: entity has no rq!\n", __func__);
>>>> +		pr_err("%s: entity has no rq!\n", __func__);
>>>
>>> Is it feasible to do something like the following?
>>>
>>> 		dev_err(job->sched ? job->sched->dev : NULL, "%s: entity has no rq!\n", __func__);
>>
>> I don't think that's a good idea. Although I'd assume that every driver zero-initializes its job
>> structures, I can't see a rule enforcing that. Hence, job->sched can be a random value until
>> drm_sched_job_arm() is called.
> 
> Okay. However, when using pr_err() we're losing "[drm] *ERROR* " prefix and we scan for that
> in the logs to quickly find the cause of the error.
> 
> Perhaps we can define pr_fmt() and also include "*ERROR*" so that we can get the desired result
> as the attached patch shows?

Sure, I'd add the pr_fmt() in a separate patch though.

