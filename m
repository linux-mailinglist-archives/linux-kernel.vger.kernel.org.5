Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06B37DC897
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjJaIpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjJaIpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:45:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C75FD8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:45:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31203C433C7;
        Tue, 31 Oct 2023 08:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698741931;
        bh=5wJvna+beQCOoBMamTqBSNyLMYqw9va5g3L23JcTKjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kFKGwLq7atkoZk2ctNWkWaLtX4huxVdg21TgdNNRR2yAe/z8URE4aL6tQYTYLwbSu
         RIU3UyLGInK0tgSbcbnImAPdIEfVkRxb7vHp144UVq5OrYD+6MHAGUoRWcf1VdOuAS
         pZLoa10u3NM4weaC1sgGuFsFXei+JH+fF/1sULHZoNAs6qJ17aEbgsm5x7wtwAEvYB
         KpDqxlBZiTvQjg+xLj5tKhJKVJriQNjd8gg+iMOaoCw+Vm7AYrLWxueqSOt6/veZOV
         6LsoegmdKO3Ab66D7fzLJW1hiEDt2iBo1Hk51Dx3Fa+YwE7j3VWzEWTen6Ky28l8RY
         k12bpp2L9Th+Q==
Date:   Tue, 31 Oct 2023 16:45:21 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     imx@lists.linux.dev, Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: cdns3: skip set TRB_IOC when usb_request:
 no_interrupt is true
Message-ID: <20231031084521.GA1948529@nchen-desktop>
References: <20231027183919.664271-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027183919.664271-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-27 14:39:19, Frank Li wrote:
> No completion irq is needed if no_interrupt is true. Needn't set TRB_IOC
> at this case.
> 
> Check usb_request: no_interrupt and set/skip TRB_IOC in
> cdns3_ep_run_transfer().
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 69a44bd7e5d02..cd08897f8da8b 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -1124,6 +1124,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
>  	u16 total_tdl = 0;
>  	struct scatterlist *s = NULL;
>  	bool sg_supported = !!(request->num_mapped_sgs);
> +	u32 ioc = request->no_interrupt ? 0 : TRB_IOC;
>  
>  	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
>  		num_trb = priv_ep->interval;
> @@ -1233,11 +1234,11 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
>  			control |= pcs;
>  
>  		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC  && !priv_ep->dir) {
> -			control |= TRB_IOC | TRB_ISP;
> +			control |= ioc | TRB_ISP;
>  		} else {
>  			/* for last element in TD or in SG list */
>  			if (sg_iter == (num_trb - 1) && sg_iter != 0)
> -				control |= pcs | TRB_IOC | TRB_ISP;
> +				control |= pcs | ioc | TRB_ISP;
>  		}
>  
>  		if (sg_iter)
> @@ -1268,7 +1269,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
>  	priv_req->num_of_trb = num_trb;
>  
>  	if (sg_iter == 1)
> -		trb->control |= cpu_to_le32(TRB_IOC | TRB_ISP);
> +		trb->control |= cpu_to_le32(ioc | TRB_ISP);
>  
>  	if (priv_dev->dev_ver < DEV_VER_V2 &&
>  	    (priv_ep->flags & EP_TDLCHK_EN)) {
> -- 
> 2.34.1
> 

-- 

Thanks,
Peter Chen
