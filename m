Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1671E755C60
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjGQHFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGQHFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:05:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD8110E0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:05:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B1CDC6603203;
        Mon, 17 Jul 2023 08:05:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689577509;
        bh=YF6OF5uDwTjzHT6+cUvP/uk2WnR4y9Nmtv0BAhrT2+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W0zKJl0HrAaJ9ljgRdOyE3ON0jQGvaztjIib0K0aKgPOyXv5A7n5ymvob5+Onh6cI
         lD1zdR4aSxjjy1rssZdTPde31YUmgW9RJP6CQgu54iHFXs7oQHA5CDdnVQDIaoj/Q/
         Ulxa5nQfnKgHSmtWQ9tjG+aWKotFE6lhPB4Pmv/procFu98vVylpxsM3jAXk84ALjn
         hMWr9K346gP7i5Eha6GcXaWp0MWPsZA7m84Gl0tvV10K/hcO2yy5dEySDAjA7qumS0
         ZSKJFxMS/XwBcsfihZF2AinFJDqlFz0nuwMX9FM4p1vujIQMkuBN/4rkisgEPqxNsC
         74AQTjgUy9/Aw==
Date:   Mon, 17 Jul 2023 09:05:06 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v1] drm/panfrost: Sync IRQ by job's timeout handler
Message-ID: <20230717090506.2ded4594@collabora.com>
In-Reply-To: <20230717065254.1061033-1-dmitry.osipenko@collabora.com>
References: <20230717065254.1061033-1-dmitry.osipenko@collabora.com>
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

Hi Dmitry,

On Mon, 17 Jul 2023 09:52:54 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Panfrost IRQ handler may stuck for a long time, for example this happens
> when there is a bad HDMI connection and HDMI handler takes a long time to
> finish processing, holding Panfrost. Make Panfrost's job timeout handler
> to sync IRQ before checking fence signal status in order to prevent
> spurious job timeouts due to a slow IRQ processing.

Feels like the problem should be fixed in the HDMI encoder driver
instead, so it doesn't stall the whole system when processing its
IRQs (use threaded irqs, maybe). I honestly don't think blocking in the
job timeout path to flush IRQs is a good strategy.

Regards,

Boris

> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index dbc597ab46fb..a356163da22d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -713,6 +713,8 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
>  	struct panfrost_device *pfdev = job->pfdev;
>  	int js = panfrost_job_get_slot(job);
>  
> +	synchronize_irq(pfdev->js->irq);
> +
>  	/*
>  	 * If the GPU managed to complete this jobs fence, the timeout is
>  	 * spurious. Bail out.

