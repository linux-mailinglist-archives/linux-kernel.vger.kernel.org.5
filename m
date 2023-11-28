Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21897FC1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjK1Qlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjK1Qlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:41:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B818AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:41:55 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D5D96602021;
        Tue, 28 Nov 2023 16:41:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701189713;
        bh=tuABoUfC0qfXNsTPEiQCWM4geHegIPUO3PIwRl8QJz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QdnXaOicdSl5ScL850MOn36WyeOKmMv+xP/NA+gdt93Sow7CedjbBlk6++eDTTTdL
         9hcJsqUDdzfV8nyCKdWoyaKcgYqNvHiwpa7+QEV3gLrLoBLUCCtqOBjqc6XlSl6btb
         5q1tep0Zz6r+KIeQ6BDDvSF8cAH78kIRipRkFNQORdTWxAiDqV5xMMEgOQXWx6GBMV
         VdyxZfTVDvMjnr8BQDcIK2NDnNHvG1I1VZxfnSHRWetrO99zqob0aKYK4WlczqsAEY
         JyRV38TQ7Ki2b9f7rdtFByOUCrEUDEvNWcb+GEGDenY9Y7B/gk5lOlD8ZCLf36dCv6
         stJQf7JzgyPzQ==
Date:   Tue, 28 Nov 2023 17:41:49 +0100
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
Message-ID: <20231128174149.68335f40@collabora.com>
In-Reply-To: <5f45485a-fee6-4ab9-9894-6da4491a985c@collabora.com>
References: <20231128124510.391007-1-angelogioacchino.delregno@collabora.com>
        <20231128124510.391007-4-angelogioacchino.delregno@collabora.com>
        <20231128145712.3f4d3f74@collabora.com>
        <f5208c45-54c7-4030-9985-cb7c8f1d6466@collabora.com>
        <20231128165357.2c9bfdf1@collabora.com>
        <5f45485a-fee6-4ab9-9894-6da4491a985c@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 17:10:17 +0100
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
wrote:

> >> 	if (status)
> >> 		panfrost_job_irq_handler_thread(pfdev->js->irq, (void*)pfdev);  
> > 
> > Nope, we don't need to read the STAT reg and forcibly call the threaded
> > handler if it's != 0. The synchronize_irq() call should do exactly that
> > (make sure all pending interrupts are processed before returning), and
> > our previous job_write(pfdev, JOB_INT_MASK, 0) guarantees that no new
> > interrupts will kick in after that point.
> >   
> 
> Unless we synchronize_irq() *before* masking all interrupts (which would be
> wrong, as some interrupt could still fire after execution of the ISR), we get
> *either of* two scenarios:
> 
>   - COMP_BIT_JOB is not set, softirq thread unmasks some interrupts by
>     writing to JOB_INT_MASK; or
>   - COMP_BIT_JOB is set, hardirq handler returns IRQ_NONE, the threaded
>     interrupt handler doesn't get executed, jobs are not canceled.
> 
> So if we don't forbicly call the threaded handler if RAWSTAT != 0 in there,
> and if the extra check is present in the hardirq handler, and if the hardirq
> handler wasn't executed already before our synchronize_irq() call (so: if the
> hardirq execution has to be done to synchronize irqs), we are not guaranteeing
> that jobs cancellation/dequeuing/removal/whatever-handling is done before
> entering suspend.

Except the job event processing should have happened before we reached
that point. panfrost_xxx_suspend_irq() are just here to make sure

- we're done processing pending IRQs that we started processing before
  the _INT_MASK update happened
- we ignore new ones, if any

If we end up with unprocessed JOB/MMU irqs we care about when we're
here, this should be fixed by:

1. Making sure the paths updating the MMU AS are retaining a runtime PM
  ref (pm_runtime_get_sync()) before doing their stuff, and releasing
  it (pm_runtime_put()) when they are done

2. Making sure we retain a runtime PM ref while we have jobs queued to
   the various JM queues

3. Making sure we acquire a runtime PM ref when we are about to push a
   job to one of the JM queue

For #2 and #3, we retain one runtime PM ref per active job, just before
queuing it [1], and release the ref when the job is completed [2][3].
We're not supposed to receive interrupts if we have no active jobs, and
if we do, we can safely ignore them, because there's not much we would
do with those anyway.

For #1, we retain the runtime PM ref when flushing TLBs of an
active AS, and when destroying an active MMU context. The last
operation that requires touching GPU regs is panfrost_mmu_enable(),
which is called from panfrost_mmu_as_get(), which is turn is called
from panfrost_job_hw_submit() after this function has acquired a
runtime PM ref. All MMU updates are synchronous, and the interrupts
that might result from an AS are caused by GPU jobs. Meaning that any
MMU interrupt remaining when we're in the suspend path can safely be
ignored.

> 
> That, unless the suggestion was to call panfrost_job_handle_irqs() instead of
> the handler thread like that (because reading it back, it makes sense to do so).

Nope, the suggestion was to keep things unchanged in
panfrost_job_suspend_irq(), and just add the extra is_suspended check
in panfrost_job_irq_handler().

[1]https://elixir.bootlin.com/linux/v6.7-rc3/source/drivers/gpu/drm/panfrost/panfrost_job.c#L207
[2]https://elixir.bootlin.com/linux/v6.7-rc3/source/drivers/gpu/drm/panfrost/panfrost_job.c#L462
[3]https://elixir.bootlin.com/linux/v6.7-rc3/source/drivers/gpu/drm/panfrost/panfrost_job.c#L481
[4]https://elixir.bootlin.com/linux/v6.7-rc3/source/drivers/gpu/drm/panfrost/panfrost_mmu.c#L279
[5]https://elixir.bootlin.com/linux/v6.7-rc3/source/drivers/gpu/drm/panfrost/panfrost_mmu.c#L555
