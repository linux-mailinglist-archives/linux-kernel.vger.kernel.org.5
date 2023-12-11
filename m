Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DCC80C89B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjLKL5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjLKL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:57:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF80C7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:57:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360A5C433C8;
        Mon, 11 Dec 2023 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702295849;
        bh=f7zaWwRmNF7dE+t0wkFnZGPtHDh8NCiV/vSatviei50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJCFuiwCrgd/gJPq0nQBruKCePHfDzR5dGgp2MEcGBnmLCO7wjWQNGthFNuvx1gv0
         HUJRiYO+ovvN5g8zsr6LEfl5U6P2WFdlXDE5wqKSjl8rkpyAxHiNFgiVRxeLFncil4
         DzF4lJOJwc/HcW3vmxzkv7HQEUhz6wBP0VbOLuxjoXmY8Rua/ejtiSOEaPzIKlzbMx
         zjNTQYqPn3HhXem6Mv/FfimjAHoxVJppHZAOhCVpvd4YW5GvWza2rjsgN04B1MPcuw
         YeBCT/rNvxq9WEK+36Qhf06h9bHtJdsRuHt2HxgMt4MDT6iblhxHVPWxEz8N/1Q88k
         AGhcerK4ZwGgg==
Date:   Mon, 11 Dec 2023 17:27:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: axi-dmac: Small code cleanup
Message-ID: <ZXb5IhaNiKJufH/k@matsya>
References: <20231204140352.30420-1-paul@crapouillou.net>
 <20231204140352.30420-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204140352.30420-2-paul@crapouillou.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-12-23, 15:03, Paul Cercueil wrote:
> Use a for() loop instead of a while() loop in axi_dmac_fill_linear_sg().

Why?

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/dma/dma-axi-dmac.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 2457a420c13d..760940b21eab 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -508,16 +508,13 @@ static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
>  	segment_size = ((segment_size - 1) | chan->length_align_mask) + 1;
>  
>  	for (i = 0; i < num_periods; i++) {
> -		len = period_len;
> -
> -		while (len > segment_size) {
> +		for (len = period_len; len > segment_size; sg++) {
>  			if (direction == DMA_DEV_TO_MEM)
>  				sg->dest_addr = addr;
>  			else
>  				sg->src_addr = addr;
>  			sg->x_len = segment_size;
>  			sg->y_len = 1;
> -			sg++;
>  			addr += segment_size;
>  			len -= segment_size;
>  		}
> -- 
> 2.42.0
> 

-- 
~Vinod
