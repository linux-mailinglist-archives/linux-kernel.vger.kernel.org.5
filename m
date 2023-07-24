Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF4975EE56
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGXIvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjGXIvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:51:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AE48ED
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:51:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5CC6DE0;
        Mon, 24 Jul 2023 01:51:48 -0700 (PDT)
Received: from [10.57.34.62] (unknown [10.57.34.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03B6F3F6C4;
        Mon, 24 Jul 2023 01:51:01 -0700 (PDT)
Message-ID: <ecceef7c-8243-5770-c449-6f96636106b4@arm.com>
Date:   Mon, 24 Jul 2023 09:51:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/panfrost: Sync IRQ by job's timeout handler
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230723000142.206908-1-dmitry.osipenko@collabora.com>
 <20230724085723.5e574bff@collabora.com>
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230724085723.5e574bff@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 07:57, Boris Brezillon wrote:
> On Sun, 23 Jul 2023 03:01:42 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> Panfrost IRQ handler may stuck for a long time, for example this happens
>> when there is a bad HDMI connection and HDMI handler takes a long time to
>> finish processing, holding Panfrost. Make Panfrost's job timeout handler
>> to sync IRQ before checking fence signal status in order to prevent
>> spurious job timeouts due to a slow IRQ processing.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>
>> Changelog:
>>
>> v2: - Moved synchronize_irq() after first signal-check to avoid unnecessary
>>       blocking on syncing.
>>
>>     - Added warn message about high interrupt latency.
>>
>>  drivers/gpu/drm/panfrost/panfrost_job.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
>> index dbc597ab46fb..a7663d7847a2 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
>> @@ -720,6 +720,13 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
>>  	if (dma_fence_is_signaled(job->done_fence))
>>  		return DRM_GPU_SCHED_STAT_NOMINAL;
>>  
>> +	synchronize_irq(pfdev->js->irq);
> 
> Can we add a comment here explaining why we're doing that?

Agreed, with a comment added:

Reviewed-by: Steven Price <steven.price@arm.com>

>> +
>> +	if (dma_fence_is_signaled(job->done_fence)) {
>> +		dev_warn(pfdev->dev, "unexpectedly high interrupt latency\n");
>> +		return DRM_GPU_SCHED_STAT_NOMINAL;
>> +	}
>> +
>>  	dev_err(pfdev->dev, "gpu sched timeout, js=%d, config=0x%x, status=0x%x, head=0x%x, tail=0x%x, sched_job=%p",
>>  		js,
>>  		job_read(pfdev, JS_CONFIG(js)),
> 

