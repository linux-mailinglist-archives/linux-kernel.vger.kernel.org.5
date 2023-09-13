Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3779E517
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbjIMKjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbjIMKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:39:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42B8DA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694601547; x=1726137547;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ohoQunBxsl1qyA0H9wWcNAWMbw852B4B1x6enym3TFI=;
  b=R3lvFRF7vntn/dwAi4cvMz9VszkKuq4MMv+LQUiGvVwCDuRx/x8qG4U2
   IhXkg3RkUHY0BLZiZLZjCysQSvAj034soWcJit6wEIhYEhTePXJ0GEwow
   tnzlI4dW4GrQoEGu38PGW3gmRr93za9G9kX2S9zV3jggUJEW9Lpz/GAtq
   C4MkhhtS3dLFZoYK1OPTeWhXAByTPRl140fizBYB++42zcKZL7OcLuayI
   1sFYRhWizx7sphhCh4fC22eZGwG0ScZXhlk9wc4htf1bKNhw7u5fZ67rB
   ZZVgVNV4iJyFENlDWjhpeG7Snplj+tFZ5Cw4hXSHLIl/8iX/I/YPpkVGg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409573104"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="409573104"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:39:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="744081841"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="744081841"
Received: from olindum-mobl1.ger.corp.intel.com (HELO [10.249.254.211]) ([10.249.254.211])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:39:03 -0700
Message-ID: <df85257a-02ed-4869-2421-0039a9c97db5@linux.intel.com>
Date:   Wed, 13 Sep 2023 12:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v3 6/7] drm/gpuvm: generalize
 dma_resv/extobj handling and GEM validation
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Dave Airlie <airlied@gmail.com>
Cc:     Danilo Krummrich <dakr@redhat.com>, daniel@ffwll.ch,
        matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230909153125.30032-1-dakr@redhat.com>
 <20230909153125.30032-7-dakr@redhat.com>
 <a9ef04d2-2525-65c0-2eda-45ca9a95a3a0@linux.intel.com>
 <20230913090311.5eeb026a@collabora.com>
 <CAPM=9tyf4m6gtUQ0BCraf0gB06_pxXV8gpQQsvWjeJnczmJkQQ@mail.gmail.com>
 <20230913091918.62c06a30@collabora.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20230913091918.62c06a30@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/13/23 09:19, Boris Brezillon wrote:
> On Wed, 13 Sep 2023 17:05:42 +1000
> Dave Airlie <airlied@gmail.com> wrote:
>
>> On Wed, 13 Sept 2023 at 17:03, Boris Brezillon
>> <boris.brezillon@collabora.com> wrote:
>>> On Tue, 12 Sep 2023 18:20:32 +0200
>>> Thomas Hellström <thomas.hellstrom@linux.intel.com> wrote:
>>>   
>>>>> +/**
>>>>> + * get_next_vm_bo_from_list() - get the next vm_bo element
>>>>> + * @__gpuvm: The GPU VM
>>>>> + * @__list_name: The name of the list we're iterating on
>>>>> + * @__local_list: A pointer to the local list used to store already iterated items
>>>>> + * @__prev_vm_bo: The previous element we got from drm_gpuvm_get_next_cached_vm_bo()
>>>>> + *
>>>>> + * This helper is here to provide lockless list iteration. Lockless as in, the
>>>>> + * iterator releases the lock immediately after picking the first element from
>>>>> + * the list, so list insertion deletion can happen concurrently.
>>>> Are the list spinlocks needed for that async state update from within
>>>> the dma-fence critical section we've discussed previously?
>>> Any driver calling _[un]link() from its drm_gpu_scheduler::run_job()
>>> hook will be in this situation (Panthor at the moment, PowerVR soon). I
>>> get that Xe and Nouveau don't need that because they update the VM
>>> state early (in the ioctl path), but I keep thinking this will hurt us
>>> if we don't think it through from the beginning, because once you've
>>> set this logic to depend only on resv locks, it will be pretty hard to
>>> get back to a solution which lets synchronous VM_BINDs take precedence
>>> on asynchronous request, and, with vkQueueBindSparse() passing external
>>> deps (plus the fact the VM_BIND queue might be pretty deep), it can
>>> take a long time to get your synchronous VM_BIND executed...

So this would boil down to either (possibly opt-in) keeping the spinlock 
approach or pushing the unlink out to a wq then?
BTW, as also asked in a reply to Danilo, how do you call unlink from 
run_job() when it was requiring the obj->dma_resv lock, or was that a WIP?

>>>   
>> btw what is the use case for this? do we have actual vulkan
>> applications we know will have problems here?
> I don't, but I think that's a concern Faith raised at some point (dates
> back from when I was reading threads describing how VM_BIND on i915
> should work, and I was clearly discovering this whole VM_BIND thing at
> that time, so maybe I misunderstood).
>
>> it feels like a bit of premature optimisation, but maybe we have use cases.
> Might be, but that's the sort of thing that would put us in a corner if
> we don't have a plan for when the needs arise. Besides, if we don't
> want to support that case because it's too complicated, I'd recommend
> dropping all the drm_gpuvm APIs that let people think this mode is
> valid/supported (map/remap/unmap hooks in drm_gpuvm_ops,
> drm_gpuvm_sm_[un]map helpers, etc). Keeping them around just adds to the
> confusion.

Xe allows bypassing the bind-queue with another bind-queue, but to 
completely avoid dependencies between queues the Operations may not 
overlap.  (And the definition of overlap is currently page-table 
structure updates may not overlap) but no guarantees are made about 
priority.

/Thomas



