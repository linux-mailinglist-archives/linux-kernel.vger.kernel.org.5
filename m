Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44A77FC2E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346869AbjK1PiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346835AbjK1PiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:38:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0523212A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:38:14 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A262166072A4;
        Tue, 28 Nov 2023 15:38:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701185893;
        bh=e3/Otsn1/ydHmK3ZLy1j3aRBbnocPdislrB6Lz/3Vdw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UjZ0Ytd9SiIanKYDGY7MzM5P6pEnBsDiqsLMMtinBbLUiSEjJaZHAImPnbkVMb4+I
         Bgta0s7aSFiMh4Epgvfqv8CN/cfOlir6X/quf4qa6PB5m4sCkBvkzi8D9GIreKhiBg
         ceTQunXrTRR1YTg7kfzAMNwdBARculIARFLz/UJIZxTdOIs+nG4YoMgJRe5gVeL5d8
         LxnegcTPmfZnp5sRXKO8nDQ23qSPCox8QKHb+m02yBJqHT7RUeKma3g+2K8NFehQqD
         QhOpop85A4G0rzExQaC4VYRX2Xf8Ys/PdD71e2cVKzXcs4iaxTaIDtQgifKapALuq4
         q7HlG13fxSUjQ==
Date:   Tue, 28 Nov 2023 16:38:08 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh@kernel.org, steven.price@arm.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, m.szyprowski@samsung.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 3/3] drm/panfrost: Synchronize and disable interrupts
 before powering off
Message-ID: <20231128163808.094a8afa@collabora.com>
In-Reply-To: <6c14d90f-f9e1-4af7-877e-f000b7fa1e08@collabora.com>
References: <20231128124510.391007-1-angelogioacchino.delregno@collabora.com>
        <20231128124510.391007-4-angelogioacchino.delregno@collabora.com>
        <20231128150612.17f6a095@collabora.com>
        <6c14d90f-f9e1-4af7-877e-f000b7fa1e08@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 16:10:43 +0100
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
wrote:

> Il 28/11/23 15:06, Boris Brezillon ha scritto:
> > On Tue, 28 Nov 2023 13:45:10 +0100
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > wrote:
> >   
> >> To make sure that we don't unintentionally perform any unclocked and/or
> >> unpowered R/W operation on GPU registers, before turning off clocks and
> >> regulators we must make sure that no GPU, JOB or MMU ISR execution is
> >> pending: doing that required to add a mechanism to synchronize the
> >> interrupts on suspend.
> >>
> >> Add functions panfrost_{gpu,job,mmu}_suspend_irq() which will perform
> >> interrupts masking and ISR execution synchronization, and then call
> >> those in the panfrost_device_runtime_suspend() handler in the exact
> >> sequence of job (may require mmu!) -> mmu -> gpu.
> >>
> >> As a side note, JOB and MMU suspend_irq functions needed some special
> >> treatment: as their interrupt handlers will unmask interrupts, it was
> >> necessary to add a bitmap for "is_suspending" which is used to address
> >> the possible corner case of unintentional IRQ unmasking because of ISR
> >> execution after a call to synchronize_irq().
> >>
> >> Of course, unmasking the interrupts is being done as part of the reset
> >> happening during runtime_resume(): since we're anyway resuming all of
> >> GPU, JOB, MMU, the only additional action is to zero out the newly
> >> introduced `is_suspending` bitmap directly in the resume handler, as
> >> to avoid adding panfrost_{job,mmu}_resume_irq() function just for
> >> clearing own bits, especially because it currently makes way more sense
> >> to just zero out the bitmap.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> ---
> >>   drivers/gpu/drm/panfrost/panfrost_device.c |  4 ++++
> >>   drivers/gpu/drm/panfrost/panfrost_device.h |  7 +++++++
> >>   drivers/gpu/drm/panfrost/panfrost_gpu.c    |  7 +++++++
> >>   drivers/gpu/drm/panfrost/panfrost_gpu.h    |  1 +
> >>   drivers/gpu/drm/panfrost/panfrost_job.c    | 18 +++++++++++++++---
> >>   drivers/gpu/drm/panfrost/panfrost_job.h    |  1 +
> >>   drivers/gpu/drm/panfrost/panfrost_mmu.c    | 17 ++++++++++++++---
> >>   drivers/gpu/drm/panfrost/panfrost_mmu.h    |  1 +
> >>   8 files changed, 50 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> >> index c90ad5ee34e7..ed34aa55a7da 100644
> >> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> >> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> >> @@ -407,6 +407,7 @@ static int panfrost_device_runtime_resume(struct device *dev)
> >>   {
> >>   	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> >>   
> >> +	bitmap_zero(pfdev->is_suspending, PANFROST_COMP_BIT_MAX);  
> > 
> > I would let each sub-block clear their bit in the reset path, since
> > that's where the IRQs are effectively unmasked.
> >   
> 
> 
> Honestly I wouldn't like seeing that: the reason is that this is something that
> is done *for* suspend/resume and only for that, while reset may be called out of
> the suspend/resume handlers.
> 
> I find clearing the suspend bits in the HW reset path a bit confusing, especially
> when it is possible to avoid doing it there...

Well, I do think it's preferable to keep the irq_is_no_longer_suspended
state update where the interrupt is effectively unmasked. Note that
when you do a reset, the IRQ is silently suspended just after the
reset happens, because the xxx_INT_MASKs are restored to their default
value, so I do consider that clearing this bit in the reset path makes
sense.

> 
> >>   	panfrost_device_reset(pfdev);
> >>   	panfrost_devfreq_resume(pfdev);
> >>   
> >> @@ -421,6 +422,9 @@ static int panfrost_device_runtime_suspend(struct device *dev)
> >>   		return -EBUSY;
> >>   
> >>   	panfrost_devfreq_suspend(pfdev);
> >> +	panfrost_job_suspend_irq(pfdev);
> >> +	panfrost_mmu_suspend_irq(pfdev);
> >> +	panfrost_gpu_suspend_irq(pfdev);
> >>   	panfrost_gpu_power_off(pfdev);
> >>   
> >>   	return 0;
> >> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> >> index 54a8aad54259..29f89f2d3679 100644
> >> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> >> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> >> @@ -25,6 +25,12 @@ struct panfrost_perfcnt;
> >>   #define NUM_JOB_SLOTS 3
> >>   #define MAX_PM_DOMAINS 5
> >>   
> >> +enum panfrost_drv_comp_bits {
> >> +	PANFROST_COMP_BIT_MMU,
> >> +	PANFROST_COMP_BIT_JOB,
> >> +	PANFROST_COMP_BIT_MAX
> >> +};
> >> +
> >>   /**
> >>    * enum panfrost_gpu_pm - Supported kernel power management features
> >>    * @GPU_PM_CLK_DIS:  Allow disabling clocks during system suspend
> >> @@ -109,6 +115,7 @@ struct panfrost_device {
> >>   
> >>   	struct panfrost_features features;
> >>   	const struct panfrost_compatible *comp;
> >> +	DECLARE_BITMAP(is_suspending, PANFROST_COMP_BIT_MAX);  
> > 
> > nit: Maybe s/is_suspending/suspended_irqs/, given the state remains
> > until the device is resumed.  
> 
> If we keep the `is_suspending` name, we can use this one more generically in
> case we ever need to, what do you think?

I'm lost. Why would we want to reserve a name for something we don't
know about? My comment was mostly relating to the fact this bitmap
doesn't reflect the is_suspending state, but rather is_suspended,
because it remains set until the device is resumed. And we actually want
it to reflect the is_suspended state, so we can catch interrupts that
are not for us without reading regs in the hard irq handler, when the
GPU is suspended.
