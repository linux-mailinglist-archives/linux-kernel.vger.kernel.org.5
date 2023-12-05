Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E433B8050DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbjLEKml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjLEKmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:42:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AE9B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:42:43 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EF07C6602F1E;
        Tue,  5 Dec 2023 10:42:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701772961;
        bh=WXau+qpHnh6GYQPDtFMZ2/Fl7ub+SROjrL3fA0IaPnU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZV7y5ybOsqMlA8dMZo7tC8Kf+xgBN/h06E/pG48Emw4+18mdnPoDU51zHIUOIGmic
         8DsBoMKwy732LhXkIZTLD+mfdLuxw+pAYLLS+xS9hN7nSPT12PYCO/gPkDB3j3iPta
         UQow20cAs4+HP3PXCciFg0kYUg/Pp2S23Y8sXf5qcohFLhGcjXHEv9Lnn67MT2gPc2
         19ApZrFa1J5yJFwDWOB5RztvLMpxET1BEjzwRmJCdyPYYlOpP3LuCVeYkmKqTZaU1i
         Ku//MCdNeTx/fpzcw2JmvortSFSlzm8kmAao4tAIjP66AncCbGl572fZPf7ulWkYeB
         u1toXdc3eSI6g==
Date:   Tue, 5 Dec 2023 11:42:37 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh@kernel.org, steven.price@arm.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, m.szyprowski@samsung.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v4 0/3] drm/panfrost: Fix poweroff and sync IRQs for
 suspend
Message-ID: <20231205114237.72c69160@collabora.com>
In-Reply-To: <20231204114215.54575-1-angelogioacchino.delregno@collabora.com>
References: <20231204114215.54575-1-angelogioacchino.delregno@collabora.com>
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

On Mon,  4 Dec 2023 12:42:12 +0100
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
wrote:

> Changes in v4:
>  - Added checks for is_suspended bits in hardirqs
>  - Added GPU suspended bit (and handling of it)
>  - Reordered panfrost_drv_comp_bits entries
>  - Commit description fixes
> 
> Changes in v3:
>  - Removed useless GPU_INT_CLEAR write in suspend path
>  - Changed to clear suspend bits in job/mmu reset path
> 
> This series contains a fast fix for the basic GPU poweroff functionality
> and goes further by implementing interrupt masking and synchronization
> before suspend.
> 
> For more information, please look at the conversation at [1], which
> explains the regression seen with the poweroff commit and the initial
> approaches taken to solve that.
> 
> Cheers!
> 
> [1]: https://lore.kernel.org/all/20231123095320.41433-1-angelogioacchino.delregno@collabora.com/
> 
> AngeloGioacchino Del Regno (3):
>   drm/panfrost: Ignore core_mask for poweroff and disable PWRTRANS irq
>   drm/panfrost: Add gpu_irq, mmu_irq to struct panfrost_device
>   drm/panfrost: Synchronize and disable interrupts before powering off

Queued to drm-misc-next.

Thanks,

Boris

> 
>  drivers/gpu/drm/panfrost/panfrost_device.c |  3 ++
>  drivers/gpu/drm/panfrost/panfrost_device.h | 10 ++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c    | 40 ++++++++++++++++------
>  drivers/gpu/drm/panfrost/panfrost_gpu.h    |  1 +
>  drivers/gpu/drm/panfrost/panfrost_job.c    | 26 +++++++++++---
>  drivers/gpu/drm/panfrost/panfrost_job.h    |  1 +
>  drivers/gpu/drm/panfrost/panfrost_mmu.c    | 32 ++++++++++++-----
>  drivers/gpu/drm/panfrost/panfrost_mmu.h    |  1 +
>  8 files changed, 91 insertions(+), 23 deletions(-)
> 

