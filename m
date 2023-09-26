Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4397AEC38
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjIZMMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjIZMML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:12:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B31124;
        Tue, 26 Sep 2023 05:12:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5A4C433C7;
        Tue, 26 Sep 2023 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695730323;
        bh=4gshwzCPEkOGDm7Y/2pNlO1HGa6D9u9xDYT4Qd0MLHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=anB5NgnuK8gXT1e0KMSbPuRVF7vfyBh4Vfc3TluzpTWr0xz+7ZYENG3hcPVQh1Dnc
         kl0+PnlgFhH+6WpEtywqoMRMXwcvVuU8KmkqBNb6s5DaBvTpyM2mvJH5WCm+2oLob5
         /RnMy9N4/f8H017Q2A3t76jYDtQtUShIXSRvjXZFhByxAfdb+NSV5xrdgtxzjVmVLD
         lNu3AzYPotfql5EGb/Ffzr/15zFT+zgr21ygVLxZKw5Dssgg2tJaCLsqwKzHnVljka
         HSIBAM5lEU1rVwWAdxJN4rJ3hvTK5MkU6R7IfjpSw5ouLFJVDNOztwusOrAWrfvg1g
         Y1DlI1FdYtJIQ==
Date:   Tue, 26 Sep 2023 20:11:52 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: chipidea: Fix DMA overwrite for Tegra
Message-ID: <20230926121152.GA2074070@nchen-desktop>
References: <cover.1695497666.git.mirq-linux@rere.qmqm.pl>
 <d93fc79f2fcc8da5166ccb99c5703ff3fdb46259.1695497666.git.mirq-linux@rere.qmqm.pl>
 <20230925114522.GA2070044@nchen-desktop>
 <ZRIdg29ADFmKnlAQ@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRIdg29ADFmKnlAQ@qmqm.qmqm.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-09-26 01:53:39, Michał Mirosław wrote:
> On Mon, Sep 25, 2023 at 07:45:22PM +0800, Peter Chen wrote:
> > On 23-09-23 21:41:55, Michał Mirosław wrote:
> > > Tegra USB controllers seem to issue DMA in doubleword-sized chunks and thus
> > > may write past the buffer provided. This is detected by SLUB:
> > > 
> > > =============================================================================
> > > BUG kmalloc-64 (Tainted: G    B             ): kmalloc Redzone overwritten
> > > -----------------------------------------------------------------------------
> > > 
> > > 0x8555cd02-0x8555cd03 @offset=3330. First byte 0x0 instead of 0xcc
> > > Allocated in usb_get_status+0x2b/0xac age=1 cpu=3 pid=41
> > >  __kmem_cache_alloc_node+0x12f/0x1e4
> > >  __kmalloc+0x33/0x8c
> > >  usb_get_status+0x2b/0xac
> > >  hub_probe+0x5e9/0xcec
> > >  usb_probe_interface+0xbf/0x21c
> > >  really_probe+0xa5/0x2c4
> > >  __driver_probe_device+0x75/0x174
> > >  driver_probe_device+0x31/0x94
> > >  __device_attach_driver+0x65/0xc0
> > >  bus_for_each_drv+0x4b/0x74
> > >  __device_attach+0x69/0x120
> > >  bus_probe_device+0x65/0x6c
> > >  device_add+0x48b/0x5f8
> > >  usb_set_configuration+0x37b/0x6b4
> > >  usb_generic_driver_probe+0x37/0x68
> > >  usb_probe_device+0x35/0xb4
> > > Slab 0xbf622b80 objects=21 used=18 fp=0x8555cdc0 flags=0x800(slab|zone=0)
> > > Object 0x8555cd00 @offset=3328 fp=0x00000000
> > > 
> > > Redzone  8555ccc0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
> > > Redzone  8555ccd0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
> > > Redzone  8555cce0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
> > > Redzone  8555ccf0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
> > > Object   8555cd00: 01 00 00 00 cc cc cc cc cc cc cc cc cc cc cc cc  ................
> > > Object   8555cd10: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
> > > Object   8555cd20: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
> > > Object   8555cd30: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
> > > Redzone  8555cd40: cc cc cc cc                                      ....
> > > Padding  8555cd74: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a              ZZZZZZZZZZZZ
> > > CPU: 3 PID: 41 Comm: kworker/3:1 Tainted: G    B              6.6.0-rc1mq-00118-g59786f827ea1 #1115
> > > Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> > > Workqueue: usb_hub_wq hub_event
> > > [<8010ca28>] (unwind_backtrace) from [<801090a5>] (show_stack+0x11/0x14)
> > > [<801090a5>] (show_stack) from [<805da2fb>] (dump_stack_lvl+0x4d/0x7c)
> > > [<805da2fb>] (dump_stack_lvl) from [<8026464f>] (check_bytes_and_report+0xb3/0xe4)
> > > [<8026464f>] (check_bytes_and_report) from [<802648e1>] (check_object+0x261/0x290)
> > > [<802648e1>] (check_object) from [<802671b1>] (free_to_partial_list+0x105/0x3f8)
> > > [<802671b1>] (free_to_partial_list) from [<80268613>] (__kmem_cache_free+0x103/0x128)
> > > [<80268613>] (__kmem_cache_free) from [<80425a67>] (usb_get_status+0x73/0xac)
> > > [<80425a67>] (usb_get_status) from [<80421b31>] (hub_probe+0x5e9/0xcec)
> > > [<80421b31>] (hub_probe) from [<80428bbb>] (usb_probe_interface+0xbf/0x21c)
> > > [<80428bbb>] (usb_probe_interface) from [<803ee13d>] (really_probe+0xa5/0x2c4)
> > > [<803ee13d>] (really_probe) from [<803ee3d1>] (__driver_probe_device+0x75/0x174)
> > > [<803ee3d1>] (__driver_probe_device) from [<803ee501>] (driver_probe_device+0x31/0x94)
> > > usb 1-1: device descriptor read/8, error -71
> > > 
> > > Fixes: fc53d5279094 ("usb: chipidea: tegra: Support host mode")
> > > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > > ---
> > >  drivers/usb/chipidea/host.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> > > index 08af26b762a2..abddd39d1ff1 100644
> > > --- a/drivers/usb/chipidea/host.c
> > > +++ b/drivers/usb/chipidea/host.c
> > > @@ -411,12 +411,13 @@ static int ci_hdrc_alloc_dma_aligned_buffer(struct urb *urb, gfp_t mem_flags)
> > >  	const unsigned int ci_hdrc_usb_dma_align = 32;
> > >  	size_t kmalloc_size;
> > >  
> > > -	if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
> > > -	    !((uintptr_t)urb->transfer_buffer & (ci_hdrc_usb_dma_align - 1)))
> > > +	if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0)
> > > +		return 0;
> > > +	if (!((uintptr_t)urb->transfer_buffer & (ci_hdrc_usb_dma_align - 1)) && !(urb->transfer_buffer_length & 3))
> > >  		return 0;
> > >  
> > >  	/* Allocate a buffer with enough padding for alignment */
> > > -	kmalloc_size = urb->transfer_buffer_length +
> > > +	kmalloc_size = ALIGN(urb->transfer_buffer_length, 4) +
> > >  		       sizeof(struct ci_hdrc_dma_aligned_buffer) +
> > >  		       ci_hdrc_usb_dma_align - 1;
> > >  
> > 
> > Would you please explain why you make these changes?
> 
> Can you point out what's unclear in the commit message?

You may appended below words to commit log, current commit log looks too
simple.

> This is to fix
> a buffer overflow by DMA from the USB controller as it seems to write
> data 32-bit word at a time. What the patch does is extend the workaround
> code to account for the extra room needed at the tail of the buffer.
> 
> Best Regards
> Michał Mirosław

-- 

Thanks,
Peter Chen
