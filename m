Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9186D76AA49
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjHAHua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHAHu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:50:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063E7E48
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:50:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 23EDA6607114;
        Tue,  1 Aug 2023 08:50:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690876225;
        bh=iODfF7XpW1EtsCvou+Devm/e/p/QPQYfgNk+Z1DVjng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D/oZP2a5vFfgDDUfIzfF5DzBwrLULG3v1/Sezkd70rrwoX1vyCZzpTc9/f9pmnVct
         dwCjBNMmEwYbgc7qN6ubpng/JCYGyJ78yQTvAqcawXXJ8kCL/t56opiApGTX+XP3dU
         DHYmNOJOjSd2Nta4XyX7gZnbQBIdDrfhu+JHRlOYHtvLr5Gh44j3xBN/hOkrfjBNII
         4s43I8Hlff1HRwLq9Axi9PN24KENrjDgDJCSraSg7Omae63+qWlHKtixY9GZmQfQcl
         5NzI73Hn4xlaJ1gL2LO6jH/QCRCrN8sJzxwx3w98BLqoV1H+T1y3pQFzy9+nfGqQTu
         0diEgd1ZKon4g==
Date:   Tue, 1 Aug 2023 09:50:22 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3] drm/panfrost: Sync IRQ by job's timeout handler
Message-ID: <20230801095022.2c5e66d6@collabora.com>
In-Reply-To: <20230801001427.176981-1-dmitry.osipenko@collabora.com>
References: <20230801001427.176981-1-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Aug 2023 03:14:27 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Panfrost IRQ handler may stuck for a long time, for example this happens
> when there is a bad HDMI connection and HDMI handler takes a long time to
> finish processing, holding Panfrost. Make Panfrost's job timeout handler
> to sync IRQ before checking fence signal status in order to prevent
> spurious job timeouts due to a slow IRQ processing.
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> # MediaTek MT8192 and MT8195 Chromebooks:
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Just a couple nits below.

> ---
> 
> Changelog:
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
>  drivers/gpu/drm/panfrost/panfrost_job.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index dbc597ab46fb..ea1149354f9d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -720,6 +720,21 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
>  	if (dma_fence_is_signaled(job->done_fence))
>  		return DRM_GPU_SCHED_STAT_NOMINAL;
>  
> +	/*
> +	 * Panfrost IRQ handler may take long time to process if there is

				^ may take a long time to process an
	interrupt if there is ...

> +	 * another IRQ handler hogging the processing. For example, HDMI
> +	 * may stuck in IRQ handler for a significant time in a case of bad

	For example, the HDMI encoder driver might be stuck in the IRQ
	handler ...

> +	 * cable connection. In order to catch such cases and not report
> +	 * spurious Panfrost job timeouts, synchronize the IRQ handler and
> +	 * re-check the fence status.
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

