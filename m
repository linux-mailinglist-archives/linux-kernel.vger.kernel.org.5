Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB38377D03F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbjHOQmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbjHOQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:42:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1D45B0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:42:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B56A31063;
        Tue, 15 Aug 2023 09:42:48 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66B9A3F6C4;
        Tue, 15 Aug 2023 09:42:05 -0700 (PDT)
Message-ID: <b6d28992-5adc-5df0-91e5-7fd0571b1465@arm.com>
Date:   Tue, 15 Aug 2023 17:42:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dma-debug: defer __dma_entry_alloc_check_leak() printk
 output
Content-Language: en-GB
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20230815152822.3660784-1-senozhatsky@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230815152822.3660784-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 4:26 pm, Sergey Senozhatsky wrote:
> __dma_entry_alloc_check_leak() calls printk -> serial console
> output (qcom geni) and grabs port->lock under free_entries_lock,
> which is a conflicting locking dependency chain as qcom_geni IRQ
> handler can call into dma-debug code and grab free_entries_lock
> under port->lock.
> 
> Use deferred printk in __dma_entry_alloc_check_leak() so that we
> don't acquire serial console's port->lock under free_entries_lock.

Hmm, the print really doesn't need to be under the lock anyway, it only 
needs to key off whether the "num_free_entries == 0" condition was hit 
or not. TBH I think I'd rather just shuffle that code around a bit than 
have to remember the significance of magic printk variants.

Thanks,
Robin.

> 
> Trimmed-down lockdep splat:
> 
>     The existing dependency chain (in reverse order) is:
> 
>                 -> #2 (free_entries_lock){-.-.}-{2:2}:
>          _raw_spin_lock_irqsave+0x60/0x80
>          dma_entry_alloc+0x38/0x110
>          debug_dma_map_page+0x60/0xf8
>          dma_map_page_attrs+0x1e0/0x230
>          dma_map_single_attrs.constprop.0+0x6c/0xc8
>          geni_se_rx_dma_prep+0x40/0xcc
>          qcom_geni_serial_isr+0x310/0x510
>          __handle_irq_event_percpu+0x110/0x244
>          handle_irq_event_percpu+0x20/0x54
>          handle_irq_event+0x50/0x88
>          handle_fasteoi_irq+0xa4/0xcc
>          handle_irq_desc+0x28/0x40
>          generic_handle_domain_irq+0x24/0x30
>          gic_handle_irq+0xc4/0x148
>          do_interrupt_handler+0xa4/0xb0
>          el1_interrupt+0x34/0x64
>          el1h_64_irq_handler+0x18/0x24
>          el1h_64_irq+0x64/0x68
>          arch_local_irq_enable+0x4/0x8
>          ____do_softirq+0x18/0x24
> 	...
> 
>                 -> #1 (&port_lock_key){-.-.}-{2:2}:
>          _raw_spin_lock_irqsave+0x60/0x80
>          qcom_geni_serial_console_write+0x184/0x1dc
>          console_flush_all+0x344/0x454
>          console_unlock+0x94/0xf0
>          vprintk_emit+0x238/0x24c
>          vprintk_default+0x3c/0x48
>          vprintk+0xb4/0xbc
>          _printk+0x68/0x90
>          register_console+0x230/0x38c
>          uart_add_one_port+0x338/0x494
>          qcom_geni_serial_probe+0x390/0x424
>          platform_probe+0x70/0xc0
>          really_probe+0x148/0x280
>          __driver_probe_device+0xfc/0x114
>          driver_probe_device+0x44/0x100
>          __device_attach_driver+0x64/0xdc
>          bus_for_each_drv+0xb0/0xd8
>          __device_attach+0xe4/0x140
>          device_initial_probe+0x1c/0x28
>          bus_probe_device+0x44/0xb0
>          device_add+0x538/0x668
>          of_device_add+0x44/0x50
>          of_platform_device_create_pdata+0x94/0xc8
>          of_platform_bus_create+0x270/0x304
>          of_platform_populate+0xac/0xc4
>          devm_of_platform_populate+0x60/0xac
>          geni_se_probe+0x154/0x160
>          platform_probe+0x70/0xc0
> 	...
> 
>                 -> #0 (console_owner){-...}-{0:0}:
>          __lock_acquire+0xdf8/0x109c
>          lock_acquire+0x234/0x284
>          console_flush_all+0x330/0x454
>          console_unlock+0x94/0xf0
>          vprintk_emit+0x238/0x24c
>          vprintk_default+0x3c/0x48
>          vprintk+0xb4/0xbc
>          _printk+0x68/0x90
>          dma_entry_alloc+0xb4/0x110
>          debug_dma_map_sg+0xdc/0x2f8
>          __dma_map_sg_attrs+0xac/0xe4
>          dma_map_sgtable+0x30/0x4c
>          get_pages+0x1d4/0x1e4 [msm]
>          msm_gem_pin_pages_locked+0x38/0xac [msm]
>          msm_gem_pin_vma_locked+0x58/0x88 [msm]
>          msm_ioctl_gem_submit+0xde4/0x13ac [msm]
>          drm_ioctl_kernel+0xe0/0x15c
>          drm_ioctl+0x2e8/0x3f4
>          vfs_ioctl+0x30/0x50
> 	...
> 
>   Chain exists of:
>                   console_owner --> &port_lock_key --> free_entries_lock
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock(free_entries_lock);
>                                  lock(&port_lock_key);
>                                  lock(free_entries_lock);
>     lock(console_owner);
> 
>                  *** DEADLOCK ***
> 
>   Call trace:
>    dump_backtrace+0xb4/0xf0
>    show_stack+0x20/0x30
>    dump_stack_lvl+0x60/0x84
>    dump_stack+0x18/0x24
>    print_circular_bug+0x1cc/0x234
>    check_noncircular+0x78/0xac
>    __lock_acquire+0xdf8/0x109c
>    lock_acquire+0x234/0x284
>    console_flush_all+0x330/0x454
>    console_unlock+0x94/0xf0
>    vprintk_emit+0x238/0x24c
>    vprintk_default+0x3c/0x48
>    vprintk+0xb4/0xbc
>    _printk+0x68/0x90
>    dma_entry_alloc+0xb4/0x110
>    debug_dma_map_sg+0xdc/0x2f8
>    __dma_map_sg_attrs+0xac/0xe4
>    dma_map_sgtable+0x30/0x4c
>    get_pages+0x1d4/0x1e4 [msm]
>    msm_gem_pin_pages_locked+0x38/0xac [msm]
>    msm_gem_pin_vma_locked+0x58/0x88 [msm]
>    msm_ioctl_gem_submit+0xde4/0x13ac [msm]
>    drm_ioctl_kernel+0xe0/0x15c
>    drm_ioctl+0x2e8/0x3f4
>    vfs_ioctl+0x30/0x50
>    ...
> 
> Reported-by: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>   kernel/dma/debug.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index f190651bcadd..9e11ceadc69d 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -643,9 +643,9 @@ static void __dma_entry_alloc_check_leak(void)
>   
>   	/* Shout each time we tick over some multiple of the initial pool */
>   	if (tmp < DMA_DEBUG_DYNAMIC_ENTRIES) {
> -		pr_info("dma_debug_entry pool grown to %u (%u00%%)\n",
> -			nr_total_entries,
> -			(nr_total_entries / nr_prealloc_entries));
> +		printk_deferred(KERN_INFO "dma_debug_entry pool grown to %u (%u00%%)\n",
> +				nr_total_entries,
> +				(nr_total_entries / nr_prealloc_entries));
>   	}
>   }
>   
