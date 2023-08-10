Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612A3777C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbjHJP0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjHJP0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB832683
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691681141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwasxYlmKCg6803QvS4pMEYDqQL2gFLDDqO3Y2PiOlE=;
        b=B/dWmmRTG1DNIsUPwSL8WxOCzBhXLsBLdCHdBiKm2JIcdQCHUQ5XBbhpIkaERyMNfHHWBV
        RgGtUIu2CsqQ/JMp5kasCFeAQOf870bzb16RdMkMNiZAhDcwUrppZblEfnH59EoSr33BwX
        v431vkPkq4XzMhT2vrhiGPWYeKkUqBQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-A6MacIqBPuWVSCl5F03QaQ-1; Thu, 10 Aug 2023 11:25:40 -0400
X-MC-Unique: A6MacIqBPuWVSCl5F03QaQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe5e67adc6so1049919e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691681139; x=1692285939;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwasxYlmKCg6803QvS4pMEYDqQL2gFLDDqO3Y2PiOlE=;
        b=GrShkATPEoZHOy1ITS+13TRxkIm9DDPO0OyNNGxRQD6PR28gSEK7AaBlrlB1QU2ukp
         NSlExyExnJ+MYwEnvG1GCxBv1d9DMbjsyY0XYy7rHgf229AXymfJhdPxeXMGmoWZSTxS
         8aJ15hULDx7MmpkkphL3eVIH6mXVMa2BX2sqIw4VvqsJUiMxyNgMeVhMdicrHD12HM2z
         At5fMPGVECFtda1MdBQwQn2eDmgoOGMTWhj/SZLwhw+F9sYwKFDpgruNKV+5nECRP0xL
         tb71G4rICE6xC1gTw3X5jiDtq1xs0aU3Ql06Uno2/88CmwDLDGWA+3o0JtawaVj7ykcl
         rWrg==
X-Gm-Message-State: AOJu0YxOwpiTxPRzC5fHeF3vr7ng57H9WCIEY9Zt3Q/1tOYrKMklJWgI
        uUiYh3QsZfUI/BtNDEB1+UPYA+Fx5yp/gUd7O1FtulTyfo1g5DQGKh5j764BulWcgaussh1lhMb
        YZX00JK/DGoEgWBgx9LN9CaBL
X-Received: by 2002:a05:6512:3a87:b0:4fb:8a90:396c with SMTP id q7-20020a0565123a8700b004fb8a90396cmr2337221lfu.38.1691681138700;
        Thu, 10 Aug 2023 08:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqr684/AZZMV8fUP0ejvLBtvEH6zilnD1RCmNEnIBm1MCFlCBVZlvCY+VioAWYPVRVoKVfhg==
X-Received: by 2002:a05:6512:3a87:b0:4fb:8a90:396c with SMTP id q7-20020a0565123a8700b004fb8a90396cmr2337192lfu.38.1691681138261;
        Thu, 10 Aug 2023 08:25:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id f14-20020a50ee8e000000b0051ded17b30bsm924864edr.40.2023.08.10.08.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 08:25:37 -0700 (PDT)
Message-ID: <7325990d-ee5c-2e48-9c94-8331bc38b0cc@redhat.com>
Date:   Thu, 10 Aug 2023 17:25:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next] drm/sched: support multiple rings per
 gpu_scheduler
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        airlied@gmail.com, daniel@ffwll.ch, luben.tuikov@amd.com,
        matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
        robdclark@chromium.org, sarah.walker@imgtec.com,
        ketil.johnsen@arm.com, Liviu.Dudau@arm.com, lina@asahilina.net,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        faith.ekstrand@collabora.com, bskeggs@redhat.com
Cc:     dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230809221729.3657-1-dakr@redhat.com>
 <2bd0714d-ecc0-8ebd-3300-ff66fdfecac0@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <2bd0714d-ecc0-8ebd-3300-ff66fdfecac0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 08:34, Christian König wrote:
> Am 10.08.23 um 00:17 schrieb Danilo Krummrich:
>> With the current mental model every GPU scheduler instance represents
>> a single HW ring, while every entity represents a software queue feeding
>> into one or multiple GPU scheduler instances and hence into one or
>> multiple HW rings.
>>
>> This does not really scale with firmware schedulers feeding the actual
>> HW rings, while the driver feeds the firmware scheduler through an
>> arbitrary amount of dynamically created rings, since for each of those
>> rings a GPU scheduler instance would be required and a separate kthread
>> would be created.
>>
>> To overcome this we can think of the scheduler having two modes of
>> operation, single ring mode and multi ring mode. Depending on the mode
>> of operation, the mental model differs.
>>
>> Single ring mode (which is the default) keeps the original behaviour of
>> the scheduler and its entities.
>>
>> In multi ring mode (enabled by passing the GPU scheduler the
>> DRM_GPU_SCHEDULER_MODE_MULTI_RING flag) each entity represents a ring,
>> while the GPU scheduler itself only exists to sort out job dependencies
>> and actually process the jobs of each entity.
>>
>> By just applying this different mental model, the required code change
>> is pretty minimalistic: While in single ring mode, if a job depends on a
>> dma-fence from the same scheduler instance we only wait for the
>> dependency to be scheduled (sched_fence->scheduled), in multi ring mode
>> we fall through and just wait for the dependency to fully complete
>> (sched_fence->finished) in order to avoid races between separate rings.
>> Or in other words, to pick up the schedulers existing terminology,
>> prevent dependency pipelining.
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>> Just before sending out this patch I was made aware of the "DRM Scheduler
>> changes for XE" [1] patch series.
>>
>> However, I think bringing this alternative approach into discussion could
>> be useful.
>>
>>  From a first glance it looks like that both approaches semantically 
>> aim for
>> the same goal, namely addressing firmware schedulers with arbitrary 
>> amounts
>> of software rings to feed from the driver side.
>>
>> The "XE approach" for that seems to be to make GPU scheduler instances
>> scalable by submitting jobs to a workqueue rather than creating a kthread
>> per scheduler instance, such that per software ring a scheduler 
>> instance can
>> be created. Hence the definition of a 1:1 relationship between 
>> scheduler and
>> entity.
>>
>> In Nouveau we approached it differently, such that we have just one GPU
>> scheduler per driver instance, while software rings are represented as
>> entities. As explained in the commit message, this seems to work fine, as
>> long as we can teach the scheduler to prevent dependency pipelining.
>>
>> As a hack this basically already works without this patch by just 
>> setting the
>> DRM_SCHED_FENCE_DONT_PIPELINE flag for all out-fences.
> 
> I discussed that with other AMD folks on some internal meeting when the 
> first Xe changes came up, but quickly abandoned it.
> 
> The scheduler depends on the sequential execution of submissions, 
> otherwise we can't guarantee the sequential signaling of scheduler 
> fences and this in turn is a really big NO-GO for dma_fences.
> 
> You avoid most of the problems by setting the 
> DRM_SCHED_FENCE_DONT_PIPELINE flag, but this is still something very flaky.
> 
> Additional to that essentially the scheduler would still only push a 
> limited number of submissions to the hw rings which makes the hardware 
> scheduler pretty much useless.

I agree, that is also what Matt pointed out in his reply besides some 
other limitations. Looks like we really want to keep the one GPU 
scheduler per ring relationship, unless we rework the whole scheduler 
design entirely.

Thank you for clarifying.

> 
> Christian.
> 
>>
>> [1] 
>> https://lore.kernel.org/intel-xe/20230801205103.627779-1-matthew.brost@intel.com/T/#t
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>>   drivers/gpu/drm/etnaviv/etnaviv_sched.c    |  2 +-
>>   drivers/gpu/drm/lima/lima_sched.c          |  2 +-
>>   drivers/gpu/drm/msm/msm_ringbuffer.c       |  2 +-
>>   drivers/gpu/drm/nouveau/nouveau_sched.c    |  7 +--
>>   drivers/gpu/drm/panfrost/panfrost_job.c    |  2 +-
>>   drivers/gpu/drm/scheduler/sched_entity.c   |  3 +-
>>   drivers/gpu/drm/scheduler/sched_main.c     | 55 +++++++++++++++-------
>>   drivers/gpu/drm/v3d/v3d_sched.c            | 10 ++--
>>   include/drm/gpu_scheduler.h                | 18 ++++++-
>>   10 files changed, 72 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index a2cdde0ca0a7..eed6f56e3957 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2491,7 +2491,7 @@ static int amdgpu_device_init_schedulers(struct 
>> amdgpu_device *adev)
>>               break;
>>           }
>> -        r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>> +        r = drm_sched_init(&ring->sched, 0, &amdgpu_sched_ops,
>>                      ring->num_hw_submission, 0,
>>                      timeout, adev->reset_domain->wq,
>>                      ring->sched_score, ring->name,
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c 
>> b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
>> index 1ae87dfd19c4..bfe761316ba9 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
>> @@ -133,7 +133,7 @@ int etnaviv_sched_init(struct etnaviv_gpu *gpu)
>>   {
>>       int ret;
>> -    ret = drm_sched_init(&gpu->sched, &etnaviv_sched_ops,
>> +    ret = drm_sched_init(&gpu->sched, 0, &etnaviv_sched_ops,
>>                    etnaviv_hw_jobs_limit, etnaviv_job_hang_limit,
>>                    msecs_to_jiffies(500), NULL, NULL,
>>                    dev_name(gpu->dev), gpu->dev);
>> diff --git a/drivers/gpu/drm/lima/lima_sched.c 
>> b/drivers/gpu/drm/lima/lima_sched.c
>> index ffd91a5ee299..f559d7de5658 100644
>> --- a/drivers/gpu/drm/lima/lima_sched.c
>> +++ b/drivers/gpu/drm/lima/lima_sched.c
>> @@ -488,7 +488,7 @@ int lima_sched_pipe_init(struct lima_sched_pipe 
>> *pipe, const char *name)
>>       INIT_WORK(&pipe->recover_work, lima_sched_recover_work);
>> -    return drm_sched_init(&pipe->base, &lima_sched_ops, 1,
>> +    return drm_sched_init(&pipe->base, 0, &lima_sched_ops, 1,
>>                     lima_job_hang_limit,
>>                     msecs_to_jiffies(timeout), NULL,
>>                     NULL, name, pipe->ldev->dev);
>> diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c 
>> b/drivers/gpu/drm/msm/msm_ringbuffer.c
>> index b60199184409..79fb8c96465d 100644
>> --- a/drivers/gpu/drm/msm/msm_ringbuffer.c
>> +++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
>> @@ -93,7 +93,7 @@ struct msm_ringbuffer *msm_ringbuffer_new(struct 
>> msm_gpu *gpu, int id,
>>        /* currently managing hangcheck ourselves: */
>>       sched_timeout = MAX_SCHEDULE_TIMEOUT;
>> -    ret = drm_sched_init(&ring->sched, &msm_sched_ops,
>> +    ret = drm_sched_init(&ring->sched, 0, &msm_sched_ops,
>>               num_hw_submissions, 0, sched_timeout,
>>               NULL, NULL, to_msm_bo(ring->bo)->name, gpu->dev->dev);
>>       if (ret) {
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c 
>> b/drivers/gpu/drm/nouveau/nouveau_sched.c
>> index 3424a1bf6af3..6528c09fffc9 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_sched.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
>> @@ -407,9 +407,10 @@ int nouveau_sched_init(struct nouveau_drm *drm)
>>       if (!drm->sched_wq)
>>           return -ENOMEM;
>> -    return drm_sched_init(sched, &nouveau_sched_ops,
>> -                  NOUVEAU_SCHED_HW_SUBMISSIONS, 0, job_hang_limit,
>> -                  NULL, NULL, "nouveau_sched", drm->dev->dev);
>> +    return drm_sched_init(sched, DRM_GPU_SCHEDULER_MODE_MULTI_RING,
>> +                  &nouveau_sched_ops, NOUVEAU_SCHED_HW_SUBMISSIONS,
>> +                  0, job_hang_limit, NULL, NULL, "nouveau_sched",
>> +                  drm->dev->dev);
>>   }
>>   void nouveau_sched_fini(struct nouveau_drm *drm)
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c 
>> b/drivers/gpu/drm/panfrost/panfrost_job.c
>> index dbc597ab46fb..dbbabf63f08f 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
>> @@ -814,7 +814,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
>>       for (j = 0; j < NUM_JOB_SLOTS; j++) {
>>           js->queue[j].fence_context = dma_fence_context_alloc(1);
>> -        ret = drm_sched_init(&js->queue[j].sched,
>> +        ret = drm_sched_init(&js->queue[j].sched, 0,
>>                        &panfrost_sched_ops,
>>                        nentries, 0,
>>                        msecs_to_jiffies(JOB_TIMEOUT_MS),
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c 
>> b/drivers/gpu/drm/scheduler/sched_entity.c
>> index a42763e1429d..6d1e11e6bdcd 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -401,7 +401,8 @@ static bool 
>> drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
>>       s_fence = to_drm_sched_fence(fence);
>>       if (!fence->error && s_fence && s_fence->sched == sched &&
>> -        !test_bit(DRM_SCHED_FENCE_DONT_PIPELINE, &fence->flags)) {
>> +        !test_bit(DRM_SCHED_FENCE_DONT_PIPELINE, &fence->flags) &&
>> +        !(sched->flags & DRM_GPU_SCHEDULER_MODE_MULTI_RING)) {
>>           /*
>>            * Fence is from the same scheduler, only need to wait for
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
>> b/drivers/gpu/drm/scheduler/sched_main.c
>> index 506371c42745..0c432c1dafdf 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -24,28 +24,50 @@
>>   /**
>>    * DOC: Overview
>>    *
>> - * The GPU scheduler provides entities which allow userspace to push 
>> jobs
>> - * into software queues which are then scheduled on a hardware run 
>> queue.
>> - * The software queues have a priority among them. The scheduler 
>> selects the entities
>> - * from the run queue using a FIFO. The scheduler provides dependency 
>> handling
>> - * features among jobs. The driver is supposed to provide callback 
>> functions for
>> - * backend operations to the scheduler like submitting a job to 
>> hardware run queue,
>> - * returning the dependencies of a job etc.
>> + * The GPU scheduler is mainly structured into the scheduler itself
>> + * (&drm_gpu_scheduler), scheduler entities (&drm_sched_entity) and 
>> scheduler
>> + * jobs (&drm_sched_job).
>>    *
>> - * The organisation of the scheduler is the following:
>> + * Each &drm_gpu_scheduler has different priority run queues (e.g. 
>> HIGH_HW,
>> + * HIGH_SW, KERNEL, NORMAL), which themselfs contain a list of 
>> &drm_sched_entity
>> + * objects, while each &drm_sched_entity maintains a queue of 
>> &drm_sched_jobs.
>>    *
>> - * 1. Each hw run queue has one scheduler
>> - * 2. Each scheduler has multiple run queues with different priorities
>> - *    (e.g., HIGH_HW,HIGH_SW, KERNEL, NORMAL)
>> - * 3. Each scheduler run queue has a queue of entities to schedule
>> - * 4. Entities themselves maintain a queue of jobs that will be 
>> scheduled on
>> - *    the hardware.
>> + * There are two modes of operation, single ring mode and multi ring 
>> mode.
>> + * Depending on the mode of operation, the mental model of what the 
>> named
>> + * structures represent differs.
>>    *
>> - * The jobs in a entity are always scheduled in the order that they 
>> were pushed.
>> + * In single ring mode (which is the default) every &drm_gpu_scheduler
>> + * instance represents a single HW ring, while every &drm_sched_entity
>> + * represents a software queue feeding into one or multiple 
>> &drm_gpu_scheduler
>> + * instances and hence into one or multiple HW rings.
>> + *
>> + * Single ring mode may be used when the GPU has a fixed amount of HW 
>> rings
>> + * which can be directly fed by the driver.
>> + *
>> + * In multi ring mode (enabled by passing the &drm_gpu_scheduler the
>> + * &DRM_GPU_SCHEDULER_MODE_MULTI_RING flag) each &drm_sched_entity 
>> represents a
>> + * HW ring, while the &drm_gpu_scheduler itself only exists to sort 
>> out job
>> + * dependencies and actually process the jobs of each &drm_sched_entity.
>> + *
>> + * Multi ring mode may be used when the GPU has a firmware scheduler 
>> feeding the
>> + * actual HW rings, while the driver feeds the firmware scheduler 
>> through an
>> + * arbitrary amount of dynamically created rings.
>> + *
>> + * While one or the other mental model could be applied without 
>> setting the ring
>> + * mode through a flag, the scheduler needs to know the mode of 
>> operation in
>> + * order to be able to make correct decitions when it comes to 
>> handling job
>> + * dependencies.
>> + *
>> + * Independent of the mode of operation jobs within an entity are always
>> + * scheduled in the order in which they were submitted.
>>    *
>>    * Note that once a job was taken from the entities queue and pushed 
>> to the
>>    * hardware, i.e. the pending queue, the entity must not be 
>> referenced anymore
>>    * through the jobs entity pointer.
>> + *
>> + * In order for the scheduler to actually prepare, process or free a 
>> job once it
>> + * is completed, the driver is supposed to provide the corresponding 
>> callback
>> + * functions (&drm_sched_backend_ops) to the scheduler.
>>    */
>>   #include <linux/kthread.h>
>> @@ -1082,7 +1104,7 @@ static int drm_sched_main(void *param)
>>    *
>>    * Return 0 on success, otherwise error code.
>>    */
>> -int drm_sched_init(struct drm_gpu_scheduler *sched,
>> +int drm_sched_init(struct drm_gpu_scheduler *sched, unsigned int flags,
>>              const struct drm_sched_backend_ops *ops,
>>              unsigned hw_submission, unsigned hang_limit,
>>              long timeout, struct workqueue_struct *timeout_wq,
>> @@ -1097,6 +1119,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
>>       sched->hang_limit = hang_limit;
>>       sched->score = score ? score : &sched->_score;
>>       sched->dev = dev;
>> +    sched->flags = flags;
>>       for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_COUNT; i++)
>>           drm_sched_rq_init(sched, &sched->sched_rq[i]);
>> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c 
>> b/drivers/gpu/drm/v3d/v3d_sched.c
>> index 06238e6d7f5c..4ba561014a5d 100644
>> --- a/drivers/gpu/drm/v3d/v3d_sched.c
>> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
>> @@ -387,7 +387,7 @@ v3d_sched_init(struct v3d_dev *v3d)
>>       int hang_limit_ms = 500;
>>       int ret;
>> -    ret = drm_sched_init(&v3d->queue[V3D_BIN].sched,
>> +    ret = drm_sched_init(&v3d->queue[V3D_BIN].sched, 0,
>>                    &v3d_bin_sched_ops,
>>                    hw_jobs_limit, job_hang_limit,
>>                    msecs_to_jiffies(hang_limit_ms), NULL,
>> @@ -395,7 +395,7 @@ v3d_sched_init(struct v3d_dev *v3d)
>>       if (ret)
>>           return ret;
>> -    ret = drm_sched_init(&v3d->queue[V3D_RENDER].sched,
>> +    ret = drm_sched_init(&v3d->queue[V3D_RENDER].sched, 0,
>>                    &v3d_render_sched_ops,
>>                    hw_jobs_limit, job_hang_limit,
>>                    msecs_to_jiffies(hang_limit_ms), NULL,
>> @@ -403,7 +403,7 @@ v3d_sched_init(struct v3d_dev *v3d)
>>       if (ret)
>>           goto fail;
>> -    ret = drm_sched_init(&v3d->queue[V3D_TFU].sched,
>> +    ret = drm_sched_init(&v3d->queue[V3D_TFU].sched, 0,
>>                    &v3d_tfu_sched_ops,
>>                    hw_jobs_limit, job_hang_limit,
>>                    msecs_to_jiffies(hang_limit_ms), NULL,
>> @@ -412,7 +412,7 @@ v3d_sched_init(struct v3d_dev *v3d)
>>           goto fail;
>>       if (v3d_has_csd(v3d)) {
>> -        ret = drm_sched_init(&v3d->queue[V3D_CSD].sched,
>> +        ret = drm_sched_init(&v3d->queue[V3D_CSD].sched, 0,
>>                        &v3d_csd_sched_ops,
>>                        hw_jobs_limit, job_hang_limit,
>>                        msecs_to_jiffies(hang_limit_ms), NULL,
>> @@ -420,7 +420,7 @@ v3d_sched_init(struct v3d_dev *v3d)
>>           if (ret)
>>               goto fail;
>> -        ret = drm_sched_init(&v3d->queue[V3D_CACHE_CLEAN].sched,
>> +        ret = drm_sched_init(&v3d->queue[V3D_CACHE_CLEAN].sched, 0,
>>                        &v3d_cache_clean_sched_ops,
>>                        hw_jobs_limit, job_hang_limit,
>>                        msecs_to_jiffies(hang_limit_ms), NULL,
>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>> index f9544d9b670d..afe29196cc7e 100644
>> --- a/include/drm/gpu_scheduler.h
>> +++ b/include/drm/gpu_scheduler.h
>> @@ -465,6 +465,20 @@ struct drm_sched_backend_ops {
>>       void (*free_job)(struct drm_sched_job *sched_job);
>>   };
>> +/**
>> + * DRM_GPU_SCHEDULER_MODE_MULTI_RING - Run the scheduler in multi 
>> ring mode
>> + *
>> + * The &drm_gpu_scheduler typically represents one HW ring with
>> + * &drm_sched_entities feeding into one or multiple scheduler instances.
>> + *
>> + * In multi ring mode it is assumed there is a single &drm_gpu_scheduler
>> + * instance only, where &drm_sched_entities represent rings instead.
>> + *
>> + * This is useful for GPUs where the &drm_gpu_scheduler should feed a 
>> firmware
>> + * scheduler with an arbitrary amount of rings.
>> + */
>> +#define DRM_GPU_SCHEDULER_MODE_MULTI_RING    (1 << 0)
>> +
>>   /**
>>    * struct drm_gpu_scheduler - scheduler instance-specific data
>>    *
>> @@ -493,6 +507,7 @@ struct drm_sched_backend_ops {
>>    * @ready: marks if the underlying HW is ready to work
>>    * @free_guilty: A hit to time out handler to free the guilty job.
>>    * @dev: system &struct device
>> + * @flags: the flags for the &drm_gpu_scheduler
>>    *
>>    * One scheduler is implemented for each hardware ring.
>>    */
>> @@ -517,9 +532,10 @@ struct drm_gpu_scheduler {
>>       bool                ready;
>>       bool                free_guilty;
>>       struct device            *dev;
>> +    unsigned long            flags;
>>   };
>> -int drm_sched_init(struct drm_gpu_scheduler *sched,
>> +int drm_sched_init(struct drm_gpu_scheduler *sched, unsigned int flags,
>>              const struct drm_sched_backend_ops *ops,
>>              uint32_t hw_submission, unsigned hang_limit,
>>              long timeout, struct workqueue_struct *timeout_wq,
>>
>> base-commit: e05f3938c5a7896d09736e3381675a57ffee7a0a
> 

