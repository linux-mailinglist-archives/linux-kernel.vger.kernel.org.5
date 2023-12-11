Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8096080C8E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbjLKMCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjLKMBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:01:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0712121
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:01:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DC0C433C8;
        Mon, 11 Dec 2023 12:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702296099;
        bh=oCr5WivpKHnBfuV05fpWq2BCfxH42ssUJX2KXJJzi2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdoPj2K21OzXKLz2Sa5CGfHq6A/EDzr2G1ZE31IeG9Ec8+9XpMdWmmDZEysg1zZAo
         0TBXLWYhr1dAOEc3ZJ6i533NEDrEFnuINndFDAE776FXRbQqrvBA0xGPe+i1Jt2lO7
         gGJQgmJAWmLaCvlCrcGBTqjViaT/YMeyuBYYM7OVnsNYnLw97OxcSMztWkndp2oJW2
         JksAUOY2mQ2w3vPAnuOh4VL9XBU8J4Jr//FBP26hEB5lLbXxw0I8MSFbdB4vqI/MFs
         Fs+Fm/QcaOylvzTOpQkDHXp/JcnJlp33+AzIX4eqIiBKCkJQPb+FFex2e1PBz/G2KT
         LJBpmziPF0emw==
Date:   Mon, 11 Dec 2023 17:31:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dmaengine: axi-dmac: Use only EOT interrupts when
 doing scatter-gather
Message-ID: <ZXb6FE5Z1zcmRFKO@matsya>
References: <20231204140352.30420-1-paul@crapouillou.net>
 <20231204140352.30420-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204140352.30420-5-paul@crapouillou.net>
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
> Instead of notifying userspace in the end-of-transfer (EOT) interrupt
> and program the hardware in the start-of-transfer (SOT) interrupt, we
> can do both things in the EOT, allowing us to mask the SOT, and halve
> the number of interrupts sent by the HDL core.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/dma/dma-axi-dmac.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 5109530b66de..beed91a8238c 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -415,6 +415,7 @@ static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
>  			list_del(&active->vdesc.node);
>  			vchan_cookie_complete(&active->vdesc);
>  			active = axi_dmac_active_desc(chan);
> +			start_next = !!active;

Should this be in current patch, sounds like this should be a different
patch?

>  		}
>  	} else {
>  		do {
> @@ -1000,6 +1001,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	struct axi_dmac *dmac;
>  	struct regmap *regmap;
>  	unsigned int version;
> +	u32 irq_mask = 0;
>  	int ret;
>  
>  	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
> @@ -1067,7 +1069,10 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  
>  	dma_dev->copy_align = (dmac->chan.address_align_mask + 1);
>  
> -	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, 0x00);
> +	if (dmac->chan.hw_sg)
> +		irq_mask |= AXI_DMAC_IRQ_SOT;
> +
> +	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, irq_mask);
>  
>  	if (of_dma_is_coherent(pdev->dev.of_node)) {
>  		ret = axi_dmac_read(dmac, AXI_DMAC_REG_COHERENCY_DESC);
> -- 
> 2.42.0
> 

-- 
~Vinod
