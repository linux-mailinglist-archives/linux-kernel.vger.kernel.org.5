Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541B177F85F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351700AbjHQOH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351689AbjHQOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:07:39 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BEFD9E56
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:07:37 -0700 (PDT)
Received: (qmail 475392 invoked by uid 1000); 17 Aug 2023 10:07:37 -0400
Date:   Thu, 17 Aug 2023 10:07:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: Disable connect, disconnect and over-current
 wakeup on system suspend
Message-ID: <cab8a29b-816c-41c7-8d2a-418f787e406e@rowland.harvard.edu>
References: <20230817093305.212821-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817093305.212821-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 05:33:05PM +0800, Kai-Heng Feng wrote:
> HP ProOne 440 G10 AIO sometimes cannot suspend as xHCI wakes up the
> system:
> [  445.814574] hub 2-0:1.0: hub_suspend
> [  445.814652] usb usb2: bus suspend, wakeup 0
> [  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id 11, portsc: 0x202a0

What is the meaning of the 0x202a0 bits?  What caused this wakeup?

> [  445.824639] xhci_hcd 0000:00:14.0: resume root hub
> [  445.824651] xhci_hcd 0000:00:14.0: handle_port_status: starting usb1 port polling.
> [  445.844039] xhci_hcd 0000:00:14.0: PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x20 returns -16
> [  445.844058] xhci_hcd 0000:00:14.0: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x1c0 returns -16
> [  445.844072] xhci_hcd 0000:00:14.0: PM: failed to suspend async: error -16
> [  446.276101] PM: Some devices failed to suspend, or early wake event detected
> 
> The system is designed to let display and touchpanel share the same
> power source, so when the display becomes off, the USB touchpanel also
> lost its power and disconnect itself from USB bus. That doesn't play
> well when most Desktop Environment lock and turnoff the display right
> before entering system suspend.

I don't see why that should cause any trouble.  The display gets locked 
and turned off, the touchpanel disconnects from the USB bus, and then 
the system goes into suspend.  Why would there be a wakeup signal at 
this point?

> So for system-wide suspend, also disable connect, disconnect and
> over-current wakeup to prevent spurious wakeup.

Whether to disable these things is part of the userspace policy.  The 
kernel should not make the decision; the user does by enabling or 
disabling wakeups.

Alan Stern

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/usb/host/xhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index fae994f679d4..dc499100efa6 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  #include <linux/dmi.h>
>  #include <linux/dma-mapping.h>
>  
> @@ -789,7 +790,7 @@ static void xhci_disable_hub_port_wake(struct xhci_hcd *xhci,
>  		t2 = t1;
>  
>  		/* clear wake bits if do_wake is not set */
> -		if (!do_wakeup)
> +		if (!do_wakeup || pm_suspend_target_state != PM_SUSPEND_ON)
>  			t2 &= ~PORT_WAKE_BITS;
>  
>  		/* Don't touch csc bit if connected or connect change is set */
> -- 
> 2.34.1
> 
