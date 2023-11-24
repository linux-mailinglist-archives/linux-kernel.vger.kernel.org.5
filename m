Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D02D7F7450
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbjKXMxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXMxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:53:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC68D71
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:53:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79279C433C7;
        Fri, 24 Nov 2023 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700830401;
        bh=jDYI24ELCvDTS98bS4B1Y7XrA4wLz6GtcIczEr1aodo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VZqKYnIUVvr1DuFPlEOpgbiwKJCCFaOv9LTFqBLeA49yywjaB//k5rEIoc1JXAOsY
         2i0pGQMJAXMYKG5I+cdNY2IkGLkKsdXdF+OSrHDGdZf8rAYJzwkbaC1ENFQfHybCXT
         CytGgpbeaPCx14LaK4fE8BdabYgwAgSUXC6IOnzpZxEw8ikqAwUfT+4keNaPPJ7FPL
         lGC0q8PKYO1q7bqvLg5drluWEJ+AumO59ntpiiJeMvN6Aq4n90etbh8kgWvIA7lFws
         480LN64i6+4az6DfNu3nYKzU3ybINn6hrKWZEXvnnjxkCDqmYOShWEFWVeTyJwxpMD
         2yOegHEH77jSQ==
Date:   Fri, 24 Nov 2023 18:23:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Thomas Pfaff <tpfaff@pcs.com>
Cc:     ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2 stable-6.1] dmaengine: at_hdmac: get next dma
 transfer from the right list
Message-ID: <ZWCcvK5L9vHwSfb2@matsya>
References: <15c92c2f-71e7-f4fd-b90b-412ab53e5a25@pcs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15c92c2f-71e7-f4fd-b90b-412ab53e5a25@pcs.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-11-23, 13:22, Thomas Pfaff wrote:
> From: Thomas Pfaff <tpfaff@pcs.com>
> 
> In kernel 6.1, atc_advance_work and atc_handle_error are checking for the 
> next dma transfer inside active list, but the descriptor is taken from the 
> queue instead.

Sorry that is not how this works. Please send the patch for mainline and
add a stable tag to the patches. They will be backported to stable
kernels

Also, your patch threading is broken, they appear disjoint and not as a
series

Thanks

> 
> Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
> ---
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 858bd64f1313..68c1bfbefc5c 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -490,6 +490,27 @@ atc_chain_complete(struct at_dma_chan *atchan, struct at_desc *desc)
>  	}
>  }
>  
> +/**
> + * atc_start_next - start next pending transaction if any
> + * @atchan: channel where the transaction ended
> + *
> + * Called with atchan->lock held
> + */
> +static void atc_start_next(struct at_dma_chan *atchan)
> +{
> +	struct at_desc *desc = NULL;
> +
> +	if (!list_empty(&atchan->active_list))
> +		desc = atc_first_active(atchan);
> +	else if (!list_empty(&atchan->queue)) {
> +		desc = atc_first_queued(atchan);
> +		list_move_tail(&desc->desc_node, &atchan->active_list);
> +	}
> +
> +	if (desc)
> +		atc_dostart(atchan, desc);
> +}
> +
>  /**
>   * atc_advance_work - at the end of a transaction, move forward
>   * @atchan: channel where the transaction ended
> @@ -513,11 +534,7 @@ static void atc_advance_work(struct at_dma_chan *atchan)
>  
>  	/* advance work */
>  	spin_lock_irqsave(&atchan->lock, flags);
> -	if (!list_empty(&atchan->active_list)) {
> -		desc = atc_first_queued(atchan);
> -		list_move_tail(&desc->desc_node, &atchan->active_list);
> -		atc_dostart(atchan, desc);
> -	}
> +	atc_start_next(atchan);
>  	spin_unlock_irqrestore(&atchan->lock, flags);
>  }
>  
> @@ -529,7 +546,6 @@ static void atc_advance_work(struct at_dma_chan *atchan)
>  static void atc_handle_error(struct at_dma_chan *atchan)
>  {
>  	struct at_desc *bad_desc;
> -	struct at_desc *desc;
>  	struct at_desc *child;
>  	unsigned long flags;
>  
> @@ -543,11 +559,7 @@ static void atc_handle_error(struct at_dma_chan *atchan)
>  	list_del_init(&bad_desc->desc_node);
>  
>  	/* Try to restart the controller */
> -	if (!list_empty(&atchan->active_list)) {
> -		desc = atc_first_queued(atchan);
> -		list_move_tail(&desc->desc_node, &atchan->active_list);
> -		atc_dostart(atchan, desc);
> -	}
> +	atc_start_next(atchan);
>  
>  	/*
>  	 * KERN_CRITICAL may seem harsh, but since this only happens
> 

-- 
~Vinod
