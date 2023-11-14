Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E16C7EAAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjKNHRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNHRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:17:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332FE18D;
        Mon, 13 Nov 2023 23:17:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F83AC433C7;
        Tue, 14 Nov 2023 07:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699946254;
        bh=+4kSS2cqW5ZV1rlUePkSMz5J6w5P2YeUyYN7VwsA6kQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mcXD9sWhg1oF72RJY/959llE/tvISFPr+2WfofYm3m3oKO+2p5SxNmb9gXqCaGQQz
         Pbc87hA717014dq07liKmSVat76mbxrnGNQ/pFQ2jkt5atJ/zK3qdwCKaU8iHp4SCt
         gYY4BbDtD/mp87pDGOuZNAsQJIrx9YmvwYlh5klAHrge8l0ZYlyZUh3wO+JfSeqjJw
         cmCC1QWkjFuuM9/iGXglSRUe+iGw9iD1YRqllYa4hifHN0363u8nl9N3jWnOpaq9nh
         crCOJDfZpAcOYVmPJrWYJF0iciXPF+WzLxdeZWwX3QZ3gPTHJRUhrMRPS1KWTL/RaR
         /GSSWyaMmS1cw==
Date:   Tue, 14 Nov 2023 15:17:20 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdnsp: Fix deadlock issue during using NCM gadget
Message-ID: <20231114071720.GA64573@nchen-desktop>
References: <20231108093125.224963-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108093125.224963-1-pawell@cadence.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
> 
> Disable bottom halves before acquiring the lock (and disabling
> interrupts) and enable them after dropping the lock. This ensures that
> any pending softirqs will handled right away.
> 
> cc: <stable@vger.kernel.org>
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter

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
