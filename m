Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957BE79805A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbjIHBtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjIHBty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:49:54 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938FF1BD2;
        Thu,  7 Sep 2023 18:49:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VradabB_1694137785;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VradabB_1694137785)
          by smtp.aliyun-inc.com;
          Fri, 08 Sep 2023 09:49:46 +0800
Message-ID: <1694137778.7008362-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2] virtio-mmio: fix memory leak of vm_dev
Date:   Fri, 8 Sep 2023 09:49:38 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     Maximilian Heyne <mheyne@amazon.de>, <stable@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <virtualization@lists.linux-foundation.org>
References: <20230907141716.88863-1-mheyne@amazon.de>
In-Reply-To: <20230907141716.88863-1-mheyne@amazon.de>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023 14:17:16 +0000, Maximilian Heyne <mheyne@amazon.de> wrote:
> With the recent removal of vm_dev from devres its memory is only freed
> via the callback virtio_mmio_release_dev. However, this only takes
> effect after device_add is called by register_virtio_device. Until then
> it's an unmanaged resource and must be explicitly freed on error exit.
>
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 55c91fedd03d ("virtio-mmio: don't break lifecycle of vm_dev")
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_mmio.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 97760f611295..59892a31cf76 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -631,14 +631,17 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	spin_lock_init(&vm_dev->lock);
>
>  	vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(vm_dev->base))
> -		return PTR_ERR(vm_dev->base);
> +	if (IS_ERR(vm_dev->base)) {
> +		rc = PTR_ERR(vm_dev->base);
> +		goto free_vm_dev;
> +	}
>
>  	/* Check magic value */
>  	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
>  	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
>  		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
> -		return -ENODEV;
> +		rc = -ENODEV;
> +		goto free_vm_dev;
>  	}
>
>  	/* Check device version */
> @@ -646,7 +649,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	if (vm_dev->version < 1 || vm_dev->version > 2) {
>  		dev_err(&pdev->dev, "Version %ld not supported!\n",
>  				vm_dev->version);
> -		return -ENXIO;
> +		rc = -ENXIO;
> +		goto free_vm_dev;
>  	}
>
>  	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
> @@ -655,7 +659,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
>  		 * with no function. End probing now with no error reported.
>  		 */
> -		return -ENODEV;
> +		rc = -ENODEV;
> +		goto free_vm_dev;
>  	}
>  	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
>
> @@ -685,6 +690,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  		put_device(&vm_dev->vdev.dev);
>
>  	return rc;
> +
> +free_vm_dev:
> +	kfree(vm_dev);
> +	return rc;
>  }
>
>  static int virtio_mmio_remove(struct platform_device *pdev)
> --
> 2.40.1
>
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>
