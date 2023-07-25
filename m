Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941CA760507
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGYCFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGYCFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF14810F0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 19:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690250655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z67MGBYjYCoyq8+JTBiKOe1Zhvzv4kxKJvMw3ZsNL3o=;
        b=dSyhanIjpKTvNiqjnmLYA0IsUUdOqcBq5e/aHCU0XhMapcqSZB7gaaW8moVXyFjlzWx0iN
        5RKyjCJgZvuXq58DXkq6eUXYGJHu++TL6LUdGNquv5EchcFYAVn3MBpHpGI4jDmyD5Quow
        U6NezQiRqsnjsmPenelY6/KIHopmoAM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-i7Cu1KnmNUadV6fW9qNaqA-1; Mon, 24 Jul 2023 22:04:12 -0400
X-MC-Unique: i7Cu1KnmNUadV6fW9qNaqA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993f7b196a5so330692566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 19:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690250651; x=1690855451;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z67MGBYjYCoyq8+JTBiKOe1Zhvzv4kxKJvMw3ZsNL3o=;
        b=YosHMyw6NVl1y0Sma3kRUf9/iZr/7witi/NCMtl0uSE/HG3/QJ3Xd//4bQx0fvDftW
         euJNgM8UOZ+0EeCreC0ouFi18/GZjKOb9DA7ROpr8ReJg1TgRv9zSzyc84Bag5FBplE1
         4JGbcW2JY6WQaHTo3QxV9zw7XvB4wAbXSBMR0nPipD8QDZeRbIuOkSeD9Dm1l8Azqrol
         s9yaxQfvACQmpHezF+iuTrVi/k0K8mc1E6xW1Cy/IsD9t3ULHIqrA4QUifvt66i8P+hE
         OHxoc224JKCnoCtgHz4iOqqJFtuvCyPqSu9rfc2DDx3hZ6GAEMFNlz96XvBoU5IukikZ
         44iQ==
X-Gm-Message-State: ABy/qLbpQcFB+UhCRQZGP4r7LJG78Io8oxKj22VlMDeeP/qQTvN06tuU
        RVmI2ROpkXG/V4S0FUkH7z+lu4sX5/o7vHcyFvZRD3IwT5nt53LO9q9Vai/g8R+5gcEMDWwLxHx
        Bck7qqYLgalu9wKs6b6s72Zp+
X-Received: by 2002:a50:ee97:0:b0:522:3410:de23 with SMTP id f23-20020a50ee97000000b005223410de23mr2686424edr.3.1690250651359;
        Mon, 24 Jul 2023 19:04:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFnnG8E2JjweuTwu1vKoP1TPmLoh5mFBItYTzIA1bh4fyY0dcNMLqBqWowSfV+YcVqDvjzquw==
X-Received: by 2002:a50:ee97:0:b0:522:3410:de23 with SMTP id f23-20020a50ee97000000b005223410de23mr2686399edr.3.1690250651096;
        Mon, 24 Jul 2023 19:04:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id n6-20020a056402060600b005222b471dc4sm2545935edv.95.2023.07.24.19.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 19:04:10 -0700 (PDT)
Message-ID: <542203c6-781a-dc44-6fa1-13cd20ab9e21@redhat.com>
Date:   Tue, 25 Jul 2023 04:04:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH drm-misc-next v8 11/12] drm/nouveau: implement new VM_BIND
 uAPI
Content-Language: en-US
To:     Faith Ekstrand <faith@gfxstrand.net>, airlied@gmail.com
Cc:     daniel@ffwll.ch, tzimmermann@suse.de, mripard@kernel.org,
        corbet@lwn.net, christian.koenig@amd.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        ogabbay@kernel.org, bagasdotme@gmail.com, willy@infradead.org,
        jason@jlekstrand.net, donald.robson@imgtec.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230720001443.2380-1-dakr@redhat.com>
 <20230720001443.2380-12-dakr@redhat.com>
 <CAOFGe945tp344=g-++=EAT89t0qJHZ=3yeW-k9OTbGNJodvwAg@mail.gmail.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <CAOFGe945tp344=g-++=EAT89t0qJHZ=3yeW-k9OTbGNJodvwAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/23 17:12, Faith Ekstrand wrote:
> On Wed, Jul 19, 2023 at 7:15 PM Danilo Krummrich <dakr@redhat.com 
> <mailto:dakr@redhat.com>> wrote:
> 
>     This commit provides the implementation for the new uapi motivated
>     by the
>     Vulkan API. It allows user mode drivers (UMDs) to:
> 
>     1) Initialize a GPU virtual address (VA) space via the new
>         DRM_IOCTL_NOUVEAU_VM_INIT ioctl for UMDs to specify the portion
>     of VA
>         space managed by the kernel and userspace, respectively.
> 
>     2) Allocate and free a VA space region as well as bind and unbind memory
>         to the GPUs VA space via the new DRM_IOCTL_NOUVEAU_VM_BIND ioctl.
>         UMDs can request the named operations to be processed either
>         synchronously or asynchronously. It supports DRM syncobjs
>         (incl. timelines) as synchronization mechanism. The management
>     of the
>         GPU VA mappings is implemented with the DRM GPU VA manager.
> 
>     3) Execute push buffers with the new DRM_IOCTL_NOUVEAU_EXEC ioctl. The
>         execution happens asynchronously. It supports DRM syncobj (incl.
>         timelines) as synchronization mechanism. DRM GEM object locking is
>         handled with drm_exec.
> 
>     Both, DRM_IOCTL_NOUVEAU_VM_BIND and DRM_IOCTL_NOUVEAU_EXEC, use the DRM
>     GPU scheduler for the asynchronous paths.
> 
> 
> IDK where the best place to talk about this is but this seems as good as 
> any.
> 
> I've been looking into why the Vulkan CTS runs about 2x slower for me on 
> the new UAPI and I created a little benchmark to facilitate testing:
> 
> https://gitlab.freedesktop.org/mesa/crucible/-/merge_requests/141 
> <https://gitlab.freedesktop.org/mesa/crucible/-/merge_requests/141>
> 
> The test, roughly, does the following:
>   1. Allocates and binds 1000 BOs
>   2. Constructs a pushbuf that executes a no-op compute shader.
>   3. Does a single EXEC/wait combo to warm up the kernel
>   4. Loops 10,000 times, doing SYNCOBJ_RESET (fast), EXEC, and then 
> SYNCOBJ_WAIT and times the loop
> 
> Of course, there's a bit of userspace driver overhead but that's 
> negledgable.
> 
> If you drop the top patch which allocates 1k buffers, the submit time on 
> the old uAPI is 54 us/exec vs. 66 us/exec on the new UAPI. This includes 
> the time to do a SYNCOBJ_RESET (fast), EXEC, and SYNCOBJ_WAIT.The Intel 
> driver, by comparison, is 33us/exec so it's not syncobj overhead. This 
> is a bit concerning (you'd think the new thing would be faster) but what 
> really has me concerned is the 1k buffer case.
> 
> If you include the top patch in the crucible MR, it allocates 1000 BOs 
> and VM_BINDs them. All the binding is done before the warmup EXEC. 
> Suddenly, the submit time jumps to 257 us/exec with the new UAPI. The 
> old UAPI is much worse (1134 us/exec) but that's not the point. Once 
> we've done the first EXEC and created our VM bindings, the cost per EXEC 
> shouldn't change at all based on the number of BOs bound.  Part of the 
> point of VM_BIND is to get all that binding logic and BO walking off the 
> EXEC path.
> 
> Normally, I wouldn't be too worried about a little performance problem 
> like this. This is the first implementation and we can improve it later. 
> I get that. However, I suspect the solution to this problem involves 
> more UAPI and I want to make sure we have it all before we call this all 
> done and dusted and land it.
> 
> The way AMD solves this problem as well as the new Xe driver for Intel 
> is to have a concept of internal vs. external BOs. Basically, there's an 
> INTERNAL bit specified somewhere in BO creation that has a few userspace 
> implications:
>   1. In the Xe world where VMs are objects, INTERNAL BOs are assigned a 
> VM on creation and can never be bound to any other VM.
>   2. Any attempt to export an INTERNAL BO via prime or a similar 
> mechanism will fail with -EINVAL (I think?).
> 
> Inside the kernel driver, all the internal BOs on a VM (or DRM file in 
> the case of nouveau/AMD since they don't have VM objects) share a single 
> dma_resv which allows you to avoid having to walk lists of BOs and take 
> locks on every exec. Instead, you can just look at the fences on the 
> dma_resv for the VM. There's still a BO list associated with the VM for 
> external BOs but, in most Vulkan applications, there are less than a 
> half dozen external BOs total.  Meanwhile, the hundreds or thousands of 
> BOs used entirely internally to the application basically count as one 
> BO when it comes to locking overhead.

I am aware of that and I have some WIP patches [1] to generalize a 
common dma-resv within the GPUVA manager which basically represents a 
GPU-VM. It also keeps track of external GEM objects and evicted objects, 
such that on EXEC we only need to validate objects needing validation, 
rather than all of them. Hence, it should be faster than with Daves 
patch having a common dma-resv only.

In [1] I also picked up Daves code to allow for noop jobs to be 
submitted as well as the NOUVEAU_GEM_DOMAIN_NO_SHARE flag.

This seems to work fine with yours and Daves latest mesa work 
(670c301a9845a3fc795fd48a1e6714e75b388245).

Your crucible bench.submit-latency test goes down to 51us on my machine 
with those patches.

I am unsure though, if we should aim for a common solution within the 
GPUVA manager directly or if we should do it driver specific in a first 
shot. I discussed this patch with Matt and I know that XE looks for 
having a generalized solution as well. However, it surely needs some 
more care and polish and feedback from other drivers perspective.

[1] 
https://gitlab.freedesktop.org/nouvelles/kernel/-/tree/new-uapi-drm-next-vm-resv

> 
> I'm not actually trying to dictate kernel driver design here. If one 
> dma_resv doesn't work, fine. I don't care as long as EXEC scales. 
> However, given that the solution in all the other drivers involves a BO 
> create flag nouveau doesn't have, we need to either add that or prove 
> that we can get EXEC to scale without it.

 From #nouveau:

<g​fxstrand> CTSing now
<g​fxstrand> It looks like it's still going to take 1.5 hours.

I may have an idea what could be the issue, let me explain.

Currently, there is a single drm_gpu_scheduler having a drm_sched_entity 
per client (for VM_BIND jobs) and a drm_sched_entity per channel (for 
EXEC jobs).

For VM_BIND jobs the corresponding PT[E]s are allocated before the job 
is pushed to the corresponding drm_sched_entity. The PT[E]s are freed by 
the schedulers free() callback pushing work to a single threaded 
workqueue doing the actual free. (We can't do it in the free() callback 
directly, since to free PT[E]s we need to hold a mutex we also need to 
hold while allocating them.)

Because of how the page table handling in Nouveau is implemented 
currently there are some ordering restrictions when it comes to 
allocating and freeing PT[E]s. For instance, we can't allocate PT[E]s 
for sparse regions before the PT[E]s of previously removed memory backed 
mappings *within the same address range* aren't freed. The same applies 
vice versa and for sparse mapping replacing sparse mapping. For memory 
backed mappings (also for those within sparse regions) we do *not* have 
such ordering requirements.

So, let's assume userspace removes a sparse region A[0x0, 0x8000000] and 
asks for a couple of new memory backed mappings within or crossing this 
range; the kernel needs to wait for A not only to be unmapped, but also 
the backing PT[E]s to be freed before it can even allocate the PT[E]s 
for the new memory backed mappings.

Now, let's have a look what the gpu schedulers main loop does. Before 
picking the next entity to schedule a job for, it tries to fetch the 
first job from the pending_list and checks whether its dma-fence is 
signaled already and whether the job can be cleaned up. Subsequent jobs 
on the pending_list are not taken into consideration. Hence, it might 
well be that the first job on the pending_list isn't signaled yet, but 
subsequent jobs are and hence *could* be cleaned up.

Normally, this shouldn't be a problem, since we wouldn't really care 
*when* resources are cleaned up as long as they are eventually. However, 
with the ordering restrictions the page table handling gives us we might 
actually care about the "when".

For instance, it could happen that the first job on the pending list is 
a rather long running EXEC job (1) scheduled from client A on some 
channel. The next job on the pending list could be a VM_BIND job (2) 
from client B removing a sparse region, which is finished already but is 
blocked to be cleaned up until the EXEC job (1) from client A is 
finished and cleaned up. Now, a subsequent VM_BIND job (3) from client B 
creating a new memory backed mapping in the same address range as the 
sparse region removed by job (2) would need to wait for (2) to be 
cleaned up. Ultimately, we can expect client B to submit an EXEC job 
that needs to wait for the corresponding mappings to be created, namely 
the VM_BIND job (3).

Clearly in order to address this we need to rework the page table 
handling in Nouveau to get rid of those ordering restrictions.

Temporarily, we could also try to run a secondary drm_gpu_scheduler 
instance, one for VM_BINDs and one for EXECs maybe...

However, I would not expect this to be an issue in real applications, 
especially if mesa takes a little care not to re-use certain address 
space areas right away to avoid running into such wait conditions.

For parallel VK CTS runs I could imagine that we run into such cases 
from time to time though.

- Danilo

> 
> ~Faith
> 

