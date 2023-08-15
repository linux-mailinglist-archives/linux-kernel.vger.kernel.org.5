Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BE977CF51
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbjHOPht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbjHOPhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:37:22 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FBF198A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:37:21 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1c4d5cc56e2so1246185fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692113839; x=1692718639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7bPWyJ4BM2lp8s+cde8/v8oklSjgzrXqoif1AHYHlI=;
        b=i5XRL2vf9vwjXJ8M4GUPI6pLku9U5KxhSZ7GxGdr62vpK6nSWIc9y5A1MQDXvZbTjQ
         Xs1jh0AC5FHYCMAwKd6SDAJUOl8D63KKgwc4WjHgyiw8za7V6fwB2EEPoYv8lrMtgl4i
         6HUeimOWR94mO9tNYl4skmERDGn5nxMjMGtFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692113839; x=1692718639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7bPWyJ4BM2lp8s+cde8/v8oklSjgzrXqoif1AHYHlI=;
        b=EusWCdIrnfpWGKwFPrEXKtazQ2/xaHAuSNvgUYxoY+LRSoOk0ExRGu0c3TWsLFTtFG
         kH9RVGsvl0axVlu1DZGcZKLHTqybDEM0wyz1a9BnHf/r94bJdUNMWM3HvPCqDBzqi8vs
         BLzrAQuuZ2vqqN1Y1ABl8a2UOd0sj0UvPTm6liJL9EWm2x/B5fvL9jEkAbT+04lLTC1A
         BxKHGIFbo+dngPLgQORx2dELZ4mg29xEcLIrxASpLFPcZvqpcjIg6Kh8Vm4skVhXwg4h
         0+V71A1dBmht11q7FggIXER1HJtk5g4T0NQGIVGkTR2Mo/csbI2ur8jDSSxO/kwXeb7H
         RbRg==
X-Gm-Message-State: AOJu0YzjRkj9notspXVlLJdn3/tW/u4/77MTu7FEJ8M84dpj04mw3hPd
        es6iIPRclC/ceS6H5kMjQFhj/SdMNTY9qYNDoqiMBQ==
X-Google-Smtp-Source: AGHT+IFLVkkHK50bZ8po8HJISFrSsj+z23izY23GgRTZvTAFZ59NxY+wD93HIKpSJip7LuJWRR2Fl2tY2wxEeeDKtGw=
X-Received: by 2002:a05:6870:65a0:b0:1b7:4521:31f with SMTP id
 fp32-20020a05687065a000b001b74521031fmr13779065oab.18.1692113839521; Tue, 15
 Aug 2023 08:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230815152822.3660784-1-senozhatsky@chromium.org>
In-Reply-To: <20230815152822.3660784-1-senozhatsky@chromium.org>
From:   Rob Clark <robdclark@chromium.org>
Date:   Tue, 15 Aug 2023 08:37:08 -0700
Message-ID: <CAJs_Fx4iRqwQjWBOgR_GV+m6___gLU5h9e2ZdT06gSggC7JLOg@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: defer __dma_entry_alloc_check_leak() printk output
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 8:28=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> __dma_entry_alloc_check_leak() calls printk -> serial console
> output (qcom geni) and grabs port->lock under free_entries_lock,
> which is a conflicting locking dependency chain as qcom_geni IRQ
> handler can call into dma-debug code and grab free_entries_lock
> under port->lock.
>
> Use deferred printk in __dma_entry_alloc_check_leak() so that we
> don't acquire serial console's port->lock under free_entries_lock.
>
> Trimmed-down lockdep splat:
>
>    The existing dependency chain (in reverse order) is:
>
>                -> #2 (free_entries_lock){-.-.}-{2:2}:
>         _raw_spin_lock_irqsave+0x60/0x80
>         dma_entry_alloc+0x38/0x110
>         debug_dma_map_page+0x60/0xf8
>         dma_map_page_attrs+0x1e0/0x230
>         dma_map_single_attrs.constprop.0+0x6c/0xc8
>         geni_se_rx_dma_prep+0x40/0xcc
>         qcom_geni_serial_isr+0x310/0x510
>         __handle_irq_event_percpu+0x110/0x244
>         handle_irq_event_percpu+0x20/0x54
>         handle_irq_event+0x50/0x88
>         handle_fasteoi_irq+0xa4/0xcc
>         handle_irq_desc+0x28/0x40
>         generic_handle_domain_irq+0x24/0x30
>         gic_handle_irq+0xc4/0x148
>         do_interrupt_handler+0xa4/0xb0
>         el1_interrupt+0x34/0x64
>         el1h_64_irq_handler+0x18/0x24
>         el1h_64_irq+0x64/0x68
>         arch_local_irq_enable+0x4/0x8
>         ____do_softirq+0x18/0x24
>         ...
>
>                -> #1 (&port_lock_key){-.-.}-{2:2}:
>         _raw_spin_lock_irqsave+0x60/0x80
>         qcom_geni_serial_console_write+0x184/0x1dc
>         console_flush_all+0x344/0x454
>         console_unlock+0x94/0xf0
>         vprintk_emit+0x238/0x24c
>         vprintk_default+0x3c/0x48
>         vprintk+0xb4/0xbc
>         _printk+0x68/0x90
>         register_console+0x230/0x38c
>         uart_add_one_port+0x338/0x494
>         qcom_geni_serial_probe+0x390/0x424
>         platform_probe+0x70/0xc0
>         really_probe+0x148/0x280
>         __driver_probe_device+0xfc/0x114
>         driver_probe_device+0x44/0x100
>         __device_attach_driver+0x64/0xdc
>         bus_for_each_drv+0xb0/0xd8
>         __device_attach+0xe4/0x140
>         device_initial_probe+0x1c/0x28
>         bus_probe_device+0x44/0xb0
>         device_add+0x538/0x668
>         of_device_add+0x44/0x50
>         of_platform_device_create_pdata+0x94/0xc8
>         of_platform_bus_create+0x270/0x304
>         of_platform_populate+0xac/0xc4
>         devm_of_platform_populate+0x60/0xac
>         geni_se_probe+0x154/0x160
>         platform_probe+0x70/0xc0
>         ...
>
>                -> #0 (console_owner){-...}-{0:0}:
>         __lock_acquire+0xdf8/0x109c
>         lock_acquire+0x234/0x284
>         console_flush_all+0x330/0x454
>         console_unlock+0x94/0xf0
>         vprintk_emit+0x238/0x24c
>         vprintk_default+0x3c/0x48
>         vprintk+0xb4/0xbc
>         _printk+0x68/0x90
>         dma_entry_alloc+0xb4/0x110
>         debug_dma_map_sg+0xdc/0x2f8
>         __dma_map_sg_attrs+0xac/0xe4
>         dma_map_sgtable+0x30/0x4c
>         get_pages+0x1d4/0x1e4 [msm]
>         msm_gem_pin_pages_locked+0x38/0xac [msm]
>         msm_gem_pin_vma_locked+0x58/0x88 [msm]
>         msm_ioctl_gem_submit+0xde4/0x13ac [msm]
>         drm_ioctl_kernel+0xe0/0x15c
>         drm_ioctl+0x2e8/0x3f4
>         vfs_ioctl+0x30/0x50
>         ...
>
>  Chain exists of:
>                  console_owner --> &port_lock_key --> free_entries_lock
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(free_entries_lock);
>                                 lock(&port_lock_key);
>                                 lock(free_entries_lock);
>    lock(console_owner);
>
>                 *** DEADLOCK ***
>
>  Call trace:
>   dump_backtrace+0xb4/0xf0
>   show_stack+0x20/0x30
>   dump_stack_lvl+0x60/0x84
>   dump_stack+0x18/0x24
>   print_circular_bug+0x1cc/0x234
>   check_noncircular+0x78/0xac
>   __lock_acquire+0xdf8/0x109c
>   lock_acquire+0x234/0x284
>   console_flush_all+0x330/0x454
>   console_unlock+0x94/0xf0
>   vprintk_emit+0x238/0x24c
>   vprintk_default+0x3c/0x48
>   vprintk+0xb4/0xbc
>   _printk+0x68/0x90
>   dma_entry_alloc+0xb4/0x110
>   debug_dma_map_sg+0xdc/0x2f8
>   __dma_map_sg_attrs+0xac/0xe4
>   dma_map_sgtable+0x30/0x4c
>   get_pages+0x1d4/0x1e4 [msm]
>   msm_gem_pin_pages_locked+0x38/0xac [msm]
>   msm_gem_pin_vma_locked+0x58/0x88 [msm]
>   msm_ioctl_gem_submit+0xde4/0x13ac [msm]
>   drm_ioctl_kernel+0xe0/0x15c
>   drm_ioctl+0x2e8/0x3f4
>   vfs_ioctl+0x30/0x50
>   ...
>
> Reported-by: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Tested-by: Rob Clark <robdclark@chromium.org>

> ---
>  kernel/dma/debug.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index f190651bcadd..9e11ceadc69d 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -643,9 +643,9 @@ static void __dma_entry_alloc_check_leak(void)
>
>         /* Shout each time we tick over some multiple of the initial pool=
 */
>         if (tmp < DMA_DEBUG_DYNAMIC_ENTRIES) {
> -               pr_info("dma_debug_entry pool grown to %u (%u00%%)\n",
> -                       nr_total_entries,
> -                       (nr_total_entries / nr_prealloc_entries));
> +               printk_deferred(KERN_INFO "dma_debug_entry pool grown to =
%u (%u00%%)\n",
> +                               nr_total_entries,
> +                               (nr_total_entries / nr_prealloc_entries))=
;
>         }
>  }
>
> --
> 2.41.0.694.ge786442a9b-goog
>
