Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DE37E6B23
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjKINUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKINUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:20:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDF7258D;
        Thu,  9 Nov 2023 05:19:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5695C433C8;
        Thu,  9 Nov 2023 13:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699535999;
        bh=2wotBFo7qvg7akdvTnz8qabiXIviFbO32EETNXcxzCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VipHGSRgz4RaLJ1IpUaB8f2kjMTcGoNbgjAZxhM+rT7bfourLW2rQnQh8As4qN6rL
         N9squphTsRbQXLLASZkkXEq/i8ZIZGGr11RV2k9Ey+YqPMdNJ/QdA0JlV4kfhu81Qt
         H4dlqU5cgxegQyxLCCsPP5XPnpoFlr+PPjXoM5371dhG+1umBuL8/VFBJSUCH/WXIA
         FonGdWquq/V06Rb37DjglS4xywdLUUOE9ufpSmbWefHWZWf9UPXrHCzk/jNSKQKFDg
         dN+U52Xwwds3GDdCEfWRl7IvyfEXIub7uxvMX84HE94/pN/2ljmHJIlEzAGeE/9cds
         KQfFxfYzooLQA==
Date:   Thu, 9 Nov 2023 21:19:48 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdnsp: Fix deadlock issue during using NCM gadget
Message-ID: <20231109131948.GB48178@nchen-desktop>
References: <20231108093125.224963-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108093125.224963-1-pawell@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-08 10:31:25, Pawel Laszczak wrote:
> The interrupt service routine registered for the gadget is a primary
> handler which mask the interrupt source and a threaded handler which
> handles the source of the interrupt. Since the threaded handler is
> voluntary threaded, the IRQ-core does not disable bottom halves before
> invoke the handler like it does for the forced-threaded handler.
> 
> Due to changes in networking it became visible that a network gadget's
> completions handler may schedule a softirq which remains unprocessed.
> The gadget's completion handler is usually invoked either in hard-IRQ or
> soft-IRQ context. In this context it is enough to just raise the softirq
> because the softirq itself will be handled once that context is left.
> In the case of the voluntary threaded handler, there is nothing that
> will process pending softirqs. Which means it remain queued until
> another random interrupt (on this CPU) fires and handles it on its exit
> path or another thread locks and unlocks a lock with the bh suffix.
> Worst case is that the CPU goes idle and the NOHZ complains about
> unhandled softirqs.

Would you have a diagram to explain how things happen, and when the
network softirq is scheduled in this case?

Peter
> 
> Disable bottom halves before acquiring the lock (and disabling
> interrupts) and enable them after dropping the lock. This ensures that
> any pending softirqs will handled right away.
> 
> cc: <stable@vger.kernel.org>
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/cdnsp-ring.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
> index 07f6068342d4..275a6a2fa671 100644
> --- a/drivers/usb/cdns3/cdnsp-ring.c
> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> @@ -1529,6 +1529,7 @@ irqreturn_t cdnsp_thread_irq_handler(int irq, void *data)
>  	unsigned long flags;
>  	int counter = 0;
>  
> +	local_bh_disable();
>  	spin_lock_irqsave(&pdev->lock, flags);
>  
>  	if (pdev->cdnsp_state & (CDNSP_STATE_HALTED | CDNSP_STATE_DYING)) {
> @@ -1541,6 +1542,7 @@ irqreturn_t cdnsp_thread_irq_handler(int irq, void *data)
>  			cdnsp_died(pdev);
>  
>  		spin_unlock_irqrestore(&pdev->lock, flags);
> +		local_bh_enable();
>  		return IRQ_HANDLED;
>  	}
>  
> @@ -1557,6 +1559,7 @@ irqreturn_t cdnsp_thread_irq_handler(int irq, void *data)
>  	cdnsp_update_erst_dequeue(pdev, event_ring_deq, 1);
>  
>  	spin_unlock_irqrestore(&pdev->lock, flags);
> +	local_bh_enable();
>  
>  	return IRQ_HANDLED;
>  }
> -- 
> 2.37.2
> 

-- 

Thanks,
Peter Chen
