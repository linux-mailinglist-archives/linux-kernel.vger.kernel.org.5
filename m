Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110FC777098
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjHJGmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjHJGmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:42:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608C3E4B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:42:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E38626607214;
        Thu, 10 Aug 2023 07:42:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691649741;
        bh=AH7PasgmgN1fEaZCrE2ClwlHFqQahh2muQjAvp9GeQ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VNRJsYk7VGrAI3ZM3AcUbmIpZYSSS+pkF7xRZCTaNIxhZRo3T/FDtclioONFy8tAY
         7NqrObI7Iy02axN1y9764P9w6VUFky0vv8dgyANXQy7qGwPf00e8NzbZX+V35FZJDv
         hTYhX3RfzADDwgvy7KXl+P+bl/yA6KgAzRORCsDcVyJ42WqZkRYJL85JecDpGppCp+
         vACbHTJJdwL/VY3XUyaH3v6LIlIAzFcf8xgR5LyC77iA+sX9PSXceMgJVy1D/br1hY
         +RDghSC/dHWSAyKXwi1iab01wCYNalvFTolAAxLZzWgrkTXpHItIc7A4X9Wj5uggHF
         J3+j79CqPzw2A==
Date:   Thu, 10 Aug 2023 08:42:19 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v4] drm/panfrost: Sync IRQ by job's timeout handler
Message-ID: <20230810084219.73ca8037@collabora.com>
In-Reply-To: <20230807000444.14926-1-dmitry.osipenko@collabora.com>
References: <20230807000444.14926-1-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Aug 2023 03:04:44 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Panfrost IRQ handler may stuck for a long time, for example this happens
> when there is a bad HDMI connection and HDMI handler takes a long time to
> finish processing, holding Panfrost. Make Panfrost's job timeout handler
> to sync IRQ before checking fence signal status in order to prevent
> spurious job timeouts due to a slow IRQ processing.
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> # MediaTek MT8192 and MT8195 Chromebooks
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Queued to drm-misc-next.

Thanks,

Boris

> ---
> 
> Changelog:
> 
> v4: - Improved comment like was suggested by Boris and added his r-b.
> 
> v3: - Added comment to the code as was suggested by Boris
> 
>     - Added r-b/t-b from Steven and Angelo
> 
> v2: - Moved synchronize_irq() after first signal-check to avoid unnecessary
>       blocking on syncing.
> 
>     - Added warn message about high interrupt latency.
> 
>  drivers/gpu/drm/panfrost/panfrost_job.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index dbc597ab46fb..db6d9a17004f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -720,6 +720,22 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
>  	if (dma_fence_is_signaled(job->done_fence))
>  		return DRM_GPU_SCHED_STAT_NOMINAL;
>  
> +	/*
> +	 * Panfrost IRQ handler may take a long time to process an interrupt
> +	 * if there is another IRQ handler hogging the processing.
> +	 * For example, the HDMI encoder driver might be stuck in the IRQ
> +	 * handler for a significant time in a case of bad cable connection.
> +	 * In order to catch such cases and not report spurious Panfrost
> +	 * job timeouts, synchronize the IRQ handler and re-check the fence
> +	 * status.
> +	 */
> +	synchronize_irq(pfdev->js->irq);
> +
> +	if (dma_fence_is_signaled(job->done_fence)) {
> +		dev_warn(pfdev->dev, "unexpectedly high interrupt latency\n");
> +		return DRM_GPU_SCHED_STAT_NOMINAL;
> +	}
> +
>  	dev_err(pfdev->dev, "gpu sched timeout, js=%d, config=0x%x, status=0x%x, head=0x%x, tail=0x%x, sched_job=%p",
>  		js,
>  		job_read(pfdev, JS_CONFIG(js)),

