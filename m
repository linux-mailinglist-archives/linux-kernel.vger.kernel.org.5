Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6FF800AF6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378863AbjLAMej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378853AbjLAMeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:34:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A4201A4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:34:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71F85143D;
        Fri,  1 Dec 2023 04:35:29 -0800 (PST)
Received: from [10.1.28.20] (e122027.cambridge.arm.com [10.1.28.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E22573F5A1;
        Fri,  1 Dec 2023 04:34:40 -0800 (PST)
Message-ID: <5cad3d21-5485-49aa-ae97-589dcb831925@arm.com>
Date:   Fri, 1 Dec 2023 12:34:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/panfrost: Synchronize and disable interrupts
 before powering off
Content-Language: en-GB
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        m.szyprowski@samsung.com, krzysztof.kozlowski@linaro.org
References: <20231201104027.35273-1-angelogioacchino.delregno@collabora.com>
 <20231201104027.35273-4-angelogioacchino.delregno@collabora.com>
 <20231201121437.7d5cdefb@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20231201121437.7d5cdefb@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2023 11:14, Boris Brezillon wrote:
> On Fri,  1 Dec 2023 11:40:27 +0100
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> wrote:
> 
>> To make sure that we don't unintentionally perform any unclocked and/or
>> unpowered R/W operation on GPU registers, before turning off clocks and
>> regulators we must make sure that no GPU, JOB or MMU ISR execution is
>> pending: doing that required to add a mechanism to synchronize the
> 
>                       ^ requires the addition of a mechanism...
> 
>> interrupts on suspend.
>>
>> Add functions panfrost_{gpu,job,mmu}_suspend_irq() which will perform
>> interrupts masking and ISR execution synchronization, and then call
>> those in the panfrost_device_runtime_suspend() handler in the exact
>> sequence of job (may require mmu!) -> mmu -> gpu.
>>
>> As a side note, JOB and MMU suspend_irq functions needed some special
>> treatment: as their interrupt handlers will unmask interrupts, it was
>> necessary to add a bitmap for `is_suspended` which is used to address
> 
>             to add an `is_suspended` bitmap which is used...
> 
>> the possible corner case of unintentional IRQ unmasking because of ISR
>> execution after a call to synchronize_irq().
> 
> Also fixes the case where the interrupt handler is called when the
> device is suspended because the IRQ line is shared with another device.
> No need to update the commit message for that though.
> 
>>
>> At resume, clear each is_suspended bit in the reset path of JOB/MMU
>> to allow unmasking the interrupts.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---

<snip>

>>  static void panfrost_job_handle_err(struct panfrost_device *pfdev,
>>  				    struct panfrost_job *job,
>>  				    unsigned int js)
>> @@ -792,9 +802,13 @@ static irqreturn_t panfrost_job_irq_handler_thread(int irq, void *data)
>>  	struct panfrost_device *pfdev = data;
>>  
>>  	panfrost_job_handle_irqs(pfdev);
>> -	job_write(pfdev, JOB_INT_MASK,
>> -		  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
>> -		  GENMASK(NUM_JOB_SLOTS - 1, 0));
>> +
>> +	/* Enable interrupts only if we're not about to get suspended */
>> +	if (!test_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended))
>> +		job_write(pfdev, JOB_INT_MASK,
>> +			  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
>> +			  GENMASK(NUM_JOB_SLOTS - 1, 0));
>> +
> 
> Missing if (test_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended)) in
> panfrost_job_irq_handler(), to make sure you don't access the registers
> if the GPU is suspended.

I think generally these IRQ handler functions should simply check the
is_suspended flag and early out if the flag is set. It's not the
re-enabling of the interrupts specifically that we want to gate - it's
any access to the hardware as in the shared-IRQ case the GPU might
already have been powered down/unclocked.

Steve

