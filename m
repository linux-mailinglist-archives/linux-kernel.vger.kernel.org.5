Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3454755DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGQIIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjGQIHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:07:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 208451705
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:07:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D66FCD75;
        Mon, 17 Jul 2023 01:07:42 -0700 (PDT)
Received: from [10.57.37.37] (unknown [10.57.37.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33EAC3F73F;
        Mon, 17 Jul 2023 01:06:58 -0700 (PDT)
Message-ID: <0b527996-342b-da44-61dd-38743db80cda@arm.com>
Date:   Mon, 17 Jul 2023 09:06:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] drm/panfrost: Sync IRQ by job's timeout handler
Content-Language: en-GB
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230717065254.1061033-1-dmitry.osipenko@collabora.com>
 <20230717090506.2ded4594@collabora.com>
 <80de081a-e443-85a2-1a61-6a8885e8d529@collabora.com>
 <20230717094905.7a1ee007@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230717094905.7a1ee007@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 08:49, Boris Brezillon wrote:
> On Mon, 17 Jul 2023 10:20:02 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> Hi,
>>
>> On 7/17/23 10:05, Boris Brezillon wrote:
>>> Hi Dmitry,
>>>
>>> On Mon, 17 Jul 2023 09:52:54 +0300
>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
>>>   
>>>> Panfrost IRQ handler may stuck for a long time, for example this happens
>>>> when there is a bad HDMI connection and HDMI handler takes a long time to
>>>> finish processing, holding Panfrost. Make Panfrost's job timeout handler
>>>> to sync IRQ before checking fence signal status in order to prevent
>>>> spurious job timeouts due to a slow IRQ processing.  
>>>
>>> Feels like the problem should be fixed in the HDMI encoder driver
>>> instead, so it doesn't stall the whole system when processing its
>>> IRQs (use threaded irqs, maybe). I honestly don't think blocking in the
>>> job timeout path to flush IRQs is a good strategy.  
>>
>> The syncing is necessary to have for correctness regardless of whether
>> it's HDMI problem or something else, there could be other reasons for
>> CPU to delay IRQ processing. It's wrong to say that hw is hung, while
>> it's not.
> 
> Well, hardware is effectively hung, if not indefinitely, at least
> temporarily. All you do here is block in the timeout handler path
> waiting for the GPU interrupt handlers to finish, handler that's
> probably waiting in the queue, because the raw HDMI handler is blocking
> it somehow. So, in the end, you might just be delaying the time of HWR a
> bit more. I know it's not GPU's fault in that case, and the job could
> have finished in time if the HDMI encoder hadn't stall the interrupt
> handling pipeline, but I'm not sure we should care for that specific
> situation. And more importantly, if it took more than 500ms to get a
> frame rendered (or, in that case, to get the event that a frame is
> rendered), you already lost, so I'm not sure correctness matters:
> rendering didn't make it in time, and the watchdog kicked in to try and
> unblock the situation. Feels like we're just papering over an HDMI
> encoder driver bug here, really.

TLDR; I don't see any major downsides and it stops the GPU getting the 
blame for something that isn't its fault.

I guess the question is whether panfrost should work on a system which 
has terrible IRQ latency. At the moment we have a synchronize_irq() call 
in panfrost_reset() which effectively does the same thing, but with all 
the overhead/spew of resetting the GPU.

Of course in the case Dmitry is actually talking about - it does seem 
like the HDMI encoder has a bug which needs fixing. There are plenty of 
other things that will break if IRQ latency gets that bad.

I do wonder if it makes sense to only synchronize when it's needed, 
e.g.:

----8<---
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index dbc597ab46fb..d96266b74e5c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -720,6 +720,12 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
 	if (dma_fence_is_signaled(job->done_fence))
 		return DRM_GPU_SCHED_STAT_NOMINAL;
 
+	/* Synchronize with the IRQ handler in case the IRQ latency is bad */
+	synchronize_irq(pfdev->js->irq);
+	/* Recheck if the job is now complete */
+	if (dma_fence_is_signaled(job->done_fence))
+		return DRM_GPU_SCHED_STAT_NOMINAL;
+
 	dev_err(pfdev->dev, "gpu sched timeout, js=%d, config=0x%x, status=0x%x, head=0x%x, tail=0x%x, sched_job=%p",
 		js,
 		job_read(pfdev, JS_CONFIG(js)),
----8<---

I don't have any data as to how often we hit the case where the DRM 
scheduler calls the timeout but we've already signalled - so the extra 
check might be overkill.

Steve
