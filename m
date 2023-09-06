Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BBA794170
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbjIFQ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjIFQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:26:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2431997;
        Wed,  6 Sep 2023 09:26:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29018C433C8;
        Wed,  6 Sep 2023 16:26:37 +0000 (UTC)
Date:   Wed, 6 Sep 2023 17:26:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-mmio: fix memory leak of vm_dev
Message-ID: <ZPioOicQ5nPtDmwJ@arm.com>
References: <20230905094228.97125-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905094228.97125-1-mheyne@amazon.de>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 09:42:28AM +0000, Maximilian Heyne wrote:
> With the recent removal of vm_dev from devres its memory is only freed
> via the callback virtio_mmio_release_dev. However, this only takes
> effect after device_add is called by register_virtio_device. Until then
> it's an unmanaged resource and must be explicitly freed on error exit.
>
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
>
> Cc: stable@vger.kernel.org
> Fixes: 55c91fedd03d ("virtio-mmio: don't break lifecycle of vm_dev")
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

Kmemleak was reporting around 31 of these leaks (under qemu). I have not
tried your patch yet as you mentioned a v2.

unreferenced object 0xffff000040bb6c00 (size 1024):
  comm "swapper/0", pid 1, jiffies 4294892472 (age 106.728s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000669bb200>] __kmem_cache_alloc_node+0x1c4/0x288
    [<00000000ac0129e3>] kmalloc_trace+0x20/0x2c
    [<0000000055d7a492>] virtio_mmio_probe+0x28/0x260
    [<000000002661dcec>] platform_probe+0x68/0xdc
    [<00000000e9abc76a>] really_probe+0x148/0x2ac
    [<00000000d9fbd8d5>] __driver_probe_device+0x78/0x12c
    [<0000000060d7804a>] driver_probe_device+0x3c/0x15c
    [<00000000705fa0e9>] __driver_attach+0x94/0x19c
    [<000000005079c97f>] bus_for_each_dev+0x74/0xd4
    [<0000000026582009>] driver_attach+0x24/0x30
    [<000000003e6b0968>] bus_add_driver+0xe4/0x1e8
    [<000000009e7b5554>] driver_register+0x60/0x128
    [<00000000d1f180b4>] __platform_driver_register+0x28/0x34
    [<0000000097a0072e>] virtio_mmio_init+0x1c/0x28
    [<00000000b3340a88>] do_one_initcall+0x6c/0x1b0
    [<0000000048f4ff06>] kernel_init_freeable+0x1bc/0x284

> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 97760f611295..b2a48d07e973 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -631,13 +631,16 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	spin_lock_init(&vm_dev->lock);
>
>  	vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(vm_dev->base))
> +	if (IS_ERR(vm_dev->base)) {
> +		kfree(vm_dev);
>  		return PTR_ERR(vm_dev->base);
> +	}
>
>  	/* Check magic value */
>  	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
>  	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
>  		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
> +		kfree(vm_dev);
>  		return -ENODEV;
>  	}
>
> @@ -646,6 +649,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	if (vm_dev->version < 1 || vm_dev->version > 2) {
>  		dev_err(&pdev->dev, "Version %ld not supported!\n",
>  				vm_dev->version);
> +		kfree(vm_dev);
>  		return -ENXIO;
>  	}
>
> @@ -655,6 +659,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
>  		 * with no function. End probing now with no error reported.
>  		 */
> +		kfree(vm_dev);
>  		return -ENODEV;
>  	}
>  	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);

I'd rather have a goto with a single point of freeing.

--
Catalin
