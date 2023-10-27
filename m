Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334087D9B44
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345883AbjJ0OYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345837AbjJ0OYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A99EC0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698416611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+jD9KdPqRoHlupMP/7iJ5h7Nb3hQw2jJJc2dYSt1fo=;
        b=dHvnGxGY5u54JIfolhRBXHXnW7XLaUd0jnjBDxypVHNPq2utsHsymzhs+aGQ33IoSpZxOu
        mFqAzhq7UjuIMCDL+xdxw8vfqnXluFxfGQwIu5tFJH7AcIcMBZwhd53QV0ubJV7b12/MG8
        F3JdQjw1LLKsUpf/HUa2ZnTAGxNuRkA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-CH4mfeYBNaSXgPoqx7GixQ-1; Fri, 27 Oct 2023 10:23:27 -0400
X-MC-Unique: CH4mfeYBNaSXgPoqx7GixQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507d0e4eedaso2455058e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416606; x=1699021406;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+jD9KdPqRoHlupMP/7iJ5h7Nb3hQw2jJJc2dYSt1fo=;
        b=s90YJSm6NIs/1w46D/n3uSAHT7md0o/HMAxI2rMIOYK8SN869TKncJ8eT9qyMeXLud
         V8OBOj28/txk57rGqmpOQa/b+/R7tWntrGthb4Ne5Po2GcnaLPaqu+X78Dfjj+XSCAXv
         mQ8YNI37jPvbYHTFc3i4rbEsXxSBsPDDUGjxi5UYqYeK4TUZ45GKawlNscNGUIlhRZR8
         Xyo7VGN3sSkIDunKY4SNXCN7D4/fpeBJ5nBlJBFpmb5XJdN4wMxCxFQbankF8KOo1U8t
         D2x2gxoe2QZURmxoydbkktUWrbHr0AzAn4wQeARxWjBMfPV6uKKqoRaX8kE8nbtRxMel
         RiKA==
X-Gm-Message-State: AOJu0YxowZ3OHa4eKZ7xTXWbDOI/nNkP/n6ascIc/tJNHczUAl+q3jXe
        mFNrbEgCQJ4DiR+rmIUb5ELhvYXy5gKqpxyugE3S3srl3plWKlGu8euDNqeC4k3DWk/POmXvg1l
        KLSJtKZhRvLSiSUDnJDKxhzvo
X-Received: by 2002:a05:6512:31d2:b0:507:9a08:4046 with SMTP id j18-20020a05651231d200b005079a084046mr2513872lfe.55.1698416606359;
        Fri, 27 Oct 2023 07:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcuzlBluWRMP0qd/U1Ab7S0Wp3s6/aFDb3j5iBXFXyMIGAoBnUH3eQi6hggX8E19JeSCEFcQ==
X-Received: by 2002:a05:6512:31d2:b0:507:9a08:4046 with SMTP id j18-20020a05651231d200b005079a084046mr2513853lfe.55.1698416606020;
        Fri, 27 Oct 2023 07:23:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d50cb000000b003231ca246b6sm1850724wrt.95.2023.10.27.07.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 07:23:25 -0700 (PDT)
Message-ID: <8e117f9f-a01c-4242-8781-b2ed4969513b@redhat.com>
Date:   Fri, 27 Oct 2023 16:23:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-misc-next v3] drm/sched: implement dynamic job-flow
 control
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        christian.koenig@amd.com, faith@gfxstrand.net,
        luben.tuikov@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231026161431.5934-1-dakr@redhat.com>
 <20231027102516.0e4b00ef@collabora.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20231027102516.0e4b00ef@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/23 10:25, Boris Brezillon wrote:
> Hi Danilo,
> 
> On Thu, 26 Oct 2023 18:13:00 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
> 
>> Currently, job flow control is implemented simply by limiting the number
>> of jobs in flight. Therefore, a scheduler is initialized with a credit
>> limit that corresponds to the number of jobs which can be sent to the
>> hardware.
>>
>> This implies that for each job, drivers need to account for the maximum
>> job size possible in order to not overflow the ring buffer.
>>
>> However, there are drivers, such as Nouveau, where the job size has a
>> rather large range. For such drivers it can easily happen that job
>> submissions not even filling the ring by 1% can block subsequent
>> submissions, which, in the worst case, can lead to the ring run dry.
>>
>> In order to overcome this issue, allow for tracking the actual job size
>> instead of the number of jobs. Therefore, add a field to track a job's
>> credit count, which represents the number of credits a job contributes
>> to the scheduler's credit limit.
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>> Changes in V2:
>> ==============
>>    - fixed up influence on scheduling fairness due to consideration of a job's
>>      size
>>      - If we reach a ready entity in drm_sched_select_entity() but can't actually
>>        queue a job from it due to size limitations, just give up and go to sleep
>>        until woken up due to a pending job finishing, rather than continue to try
>>        other entities.
>>    - added a callback to dynamically update a job's credits (Boris)
> 
> This callback seems controversial. I'd suggest dropping it, so the
> patch can be merged.

I don't think we should drop it just for the sake of moving forward. If there are objections
we'll discuss them. I've seen good reasons why the drivers you are working on require this,
while, following the discussion, I have *not* seen any reasons to drop it. It helps simplifying
driver code and doesn't introduce any complexity or overhead to existing drivers.

> 
> Regards,
> 
> Boris
> 
>>    - renamed 'units' to 'credits'
>>    - fixed commit message and comments as requested by Luben
>>
>> Changes in V3:
>> ==============
>>    - rebased onto V7 of the "DRM scheduler changes for Xe" series by Matt
>>    - move up drm_sched_can_queue() instead of adding a forward declaration
>>      (Boris)
>>    - add a drm_sched_available_credits() helper (Boris)
>>    - adjust control flow in drm_sched_rq_select_entity_fifo() to Luben's proposal
>>    - re-phrase a few comments and fix a typo (Luben)
>>    - change naming of all structures credit fields and function parameters to the
>>      following scheme
>>      - drm_sched_job::credits
>>      - drm_gpu_scheduler::credit_limit
>>      - drm_gpu_scheduler::credit_count
>>      - drm_sched_init(..., u32 credit_limit, ...)
>>      - drm_sched_job_init(..., u32 credits, ...)
>>    - add proper documentation for the scheduler's job-flow control mechanism
> 

