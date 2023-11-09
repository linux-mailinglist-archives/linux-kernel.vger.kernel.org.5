Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9607E6B04
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjKINLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjKINLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:11:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22362D7B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:11:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FD6C433C8;
        Thu,  9 Nov 2023 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699535471;
        bh=KDTvTMPiNksL74W/4/oLEC7ABrgUyx5Y9dSsvidmpeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t45PhcK8gVbwMXMf90KAaXTHO5/F4TKITgkv2aSfYoZQzWu4iUWpziHlFqXPmxZNO
         gocP6sHNtZjKdLjG7MgmGCdDo7cl5feBTNpzWgPY2W3VaH9oOrCFXVDvHIV3kkEOq5
         mKOLtUsPbXqAWmz0ZIdVTCjmipaU/aKDoecWYv/5gqf8lVXWWPixXERm29BD7ICAkS
         FbyMTprURuuP533FADd0y+CXDcQL4ckHERSILt+Q9G4F9+4x+BulfeejRE+z0ApzEn
         p6UB+C2pbnjMQ5cI/AvWiC+lJziDS78CKx+J+Zl2a1LeBPoJ0Qrqx/7Ed/9zOiAJT6
         DXv81tQCcUNpg==
Date:   Thu, 9 Nov 2023 21:11:00 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] usb: cdns3: fix uvc failure work since sg support
 enabled
Message-ID: <20231109131100.GA48178@nchen-desktop>
References: <20231106153452.2397035-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106153452.2397035-1-Frank.Li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-06 10:34:52, Frank Li wrote:
> When IP version >= DEV_VER_V2, gadget:sg_supported is true. So uvc gadget
> function driver will use sg to equeue data, first is 8bytes header, the
> second is 1016bytes data.
> 
>     cdns3_prepare_trb: ep2in: trb 0000000000ac755f, dma buf: 0xbf455000, size: 8, burst: 128 ctrl: 0x00000415 (C=1, T=0, ISP, CHAIN, Normal)
>     cdns3_prepare_trb: ep2in: trb 00000000a574e693, dma buf: 0xc0200fe0, size: 1016, burst: 128 ctrl: 0x00000405 (C=1, T=0, ISP, Normal)
> 
> But cdns3_ep_run_transfer() can't correctly handle this case, which only
> support one TRB for ISO transfer.
> 
> The controller requires duplicate the TD for each SOF if priv_ep->interval
> is not 1. DMA will read data from DDR to internal FIFO when get SOF. Send
> data to bus when receive IN token. DMA always refill FIFO when get SOF
> regardless host send IN token or not. If host send IN token later, some
> frames data will be lost.
> 
> Fixed it by below major steps:
> 
> 1. Calculate numembers of TRB base on sg_nums and priv_ep->interval.
> 2. Remove CHAIN flags for each end TRB of TD when duplicate TD.
> 3. The controller requires LINK TRB must be first TRB of TD. When check
> there are not enough TRBs lefts, just fill LINK TRB for left TRBs.
> 
> .... CHAIN_TRB DATA_TRB, CHAIN_TRB DATA_TRB,  LINK_TRB ... LINK_TRB
>                                                            ^End of TRB List
> 
> Fixes: 7733f6c32e36f ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

You mentioned android still has some problems, so let's wait your
qualify results. Since it is a big change, please test more classes
(mtp/adb/uvc/ncm).
> ---
> 
> This patch is depend on https://lore.kernel.org/imx/20231031084521.GA1948529@nchen-desktop/T/#t
> 
>  drivers/usb/cdns3/cdns3-gadget.c | 51 +++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index cd08897f8da8..23580ec33202 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -1117,6 +1117,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
>  	dma_addr_t trb_dma;
>  	u32 togle_pcs = 1;
>  	int sg_iter = 0;
> +	int num_trb_req;
>  	int num_trb;
>  	int address;
>  	u32 control;
> @@ -1126,15 +1127,13 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
>  	bool sg_supported = !!(request->num_mapped_sgs);
>  	u32 ioc = request->no_interrupt ? 0 : TRB_IOC;
>  
> +	num_trb_req = sg_supported ? request->num_mapped_sgs : 1;
> +
> +	/* ISO transfer require each SOF have a TD, each TD include some TRBs */
>  	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
> -		num_trb = priv_ep->interval;
> +		num_trb = priv_ep->interval * num_trb_req;
>  	else
> -		num_trb = sg_supported ? request->num_mapped_sgs : 1;
> -
> -	if (num_trb > priv_ep->free_trbs) {
> -		priv_ep->flags |= EP_RING_FULL;
> -		return -ENOBUFS;
> -	}
> +		num_trb = num_trb_req;
>  
>  	priv_req = to_cdns3_request(request);
>  	address = priv_ep->endpoint.desc->bEndpointAddress;
> @@ -1183,14 +1182,31 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
>  
>  		link_trb->control = cpu_to_le32(((priv_ep->pcs) ? TRB_CYCLE : 0) |
>  				    TRB_TYPE(TRB_LINK) | TRB_TOGGLE | ch_bit);
> +
> +		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC) {
> +			/*
> +			 * ISO require LINK TRB must be first one of TD.
> +			 * Fill LINK TRBs for left trb space to simply software process logic.
> +			 */
> +			while (priv_ep->enqueue) {
> +				*trb = *link_trb;
> +				trace_cdns3_prepare_trb(priv_ep, trb);
> +
> +				cdns3_ep_inc_enq(priv_ep);
> +				trb = priv_ep->trb_pool + priv_ep->enqueue;
> +				priv_req->trb = trb;
> +			}
> +		}
> +	}
> +
> +	if (num_trb > priv_ep->free_trbs) {
> +		priv_ep->flags |= EP_RING_FULL;
> +		return -ENOBUFS;
>  	}
>  
>  	if (priv_dev->dev_ver <= DEV_VER_V2)
>  		togle_pcs = cdns3_wa1_update_guard(priv_ep, trb);
>  
> -	if (sg_supported)
> -		s = request->sg;
> -
>  	/* set incorrect Cycle Bit for first trb*/
>  	control = priv_ep->pcs ? 0 : TRB_CYCLE;
>  	trb->length = 0;
> @@ -1208,6 +1224,9 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
>  	do {
>  		u32 length;
>  
> +		if (!(sg_iter % num_trb_req) && sg_supported)
> +			s = request->sg;
> +
>  		/* fill TRB */
>  		control |= TRB_TYPE(TRB_NORMAL);
>  		if (sg_supported) {
> @@ -1249,7 +1268,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
>  		if (sg_supported) {
>  			trb->control |= cpu_to_le32(TRB_ISP);
>  			/* Don't set chain bit for last TRB */
> -			if (sg_iter < num_trb - 1)
> +			if ((sg_iter % num_trb_req) < num_trb_req - 1)
>  				trb->control |= cpu_to_le32(TRB_CHAIN);
>  
>  			s = sg_next(s);
> @@ -1507,6 +1526,12 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
>  
>  		/* The TRB was changed as link TRB, and the request was handled at ep_dequeue */
>  		while (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
> +
> +			/* ISO ep_traddr may stop at LINK TRB */
> +			if (priv_ep->dequeue == cdns3_get_dma_pos(priv_dev, priv_ep) &&
> +			    priv_ep->type == USB_ENDPOINT_XFER_ISOC)
> +				break;
> +
>  			trace_cdns3_complete_trb(priv_ep, trb);
>  			cdns3_ep_inc_deq(priv_ep);
>  			trb = priv_ep->trb_pool + priv_ep->dequeue;
> @@ -1539,6 +1564,10 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
>  			}
>  
>  			if (request_handled) {
> +				/* TRBs are duplicated by priv_ep->interval time for ISO IN */
> +				if (priv_ep->type == USB_ENDPOINT_XFER_ISOC && priv_ep->dir)
> +					request->actual /= priv_ep->interval;
> +
>  				cdns3_gadget_giveback(priv_ep, priv_req, 0);
>  				request_handled = false;
>  				transfer_end = false;
> -- 
> 2.34.1
> 

-- 

Thanks,
Peter Chen
