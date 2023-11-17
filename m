Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC617EED18
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjKQIHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQIHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:07:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D33C4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:07:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA21AC433C8;
        Fri, 17 Nov 2023 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700208434;
        bh=8mPk0+JYm3DQ/U1OTjZqnq0hA5XUiluL2NaSKKnbAJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OriicWONuG8ZI22bAM9PCopeJt/Z9pIhW1mOi/bs1Dt1V7534fiCKWT/uAJQKnxv6
         o20fTzhj7ro3gXNxZxV5913jOUQGvWe+iAL2I6IcXlw8GyjyJmL458pxG3BkAGR+wN
         +yng31p5VYm1wweQ8QTOFi//29G3IPyUEPP/eKz6mXIpAiG+keEpA7yhTKI40kN8p5
         dqfI1HrWOygp1iDSIwleHGMsCJ7LswnKNDkoVRmVy/b91ONEo6XtSdq7Djo5OcVVrg
         iRhYwFZT57GQb6CmK561NK3/TKPBYG1niWSxndq361GKJpTQLXPIOVlDxf5thCHMCu
         XBGyvBUIkj9Gw==
Date:   Fri, 17 Nov 2023 13:37:08 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v5 5/6] dmaengine: dw-edma: HDMA: Add sync read before
 starting the DMA transfer in remote setup
Message-ID: <20231117080708.GD10361@thinkpad>
References: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
 <20231114-b4-feature_hdma_mainline-v5-5-7bc86d83c6f7@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114-b4-feature_hdma_mainline-v5-5-7bc86d83c6f7@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 03:51:58PM +0100, Kory Maincent wrote:
> The Linked list element and pointer are not stored in the same memory as
> the HDMA controller register. If the doorbell register is toggled before
> the full write of the linked list a race condition error will occur.
> In remote setup we can only use a readl to the memory to assure the full
> write has occurred.
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Few nitpicks below. With those addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> 
> Changes in v2:
> - Move the sync read in a function.
> - Add commments
> 
> Changes in v4:
> - Update git commit message.
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 04b0bcb6ded9..13b6aec6a6de 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -222,6 +222,20 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
>  }
>  
> +static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
> +{
> +	/*
> +	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internals

s/internals/internal

> +	 * configuration registers and Application memory are normally accessed

s/Application/application

> +	 * over different buses. Ensure LL-data reaches the memory before the
> +	 * doorbell register is toggled by issuing the dummy-read from the remote
> +	 * LL memory in a hope that the posted MRd TLP will return only after the

MRd TLP is not posted.

- Mani

> +	 * last MWr TLP is completed
> +	 */
> +	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		readl(chunk->ll_region.vaddr.io);
> +}
> +
>  static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
> @@ -252,6 +266,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  	/* Set consumer cycle */
>  	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
>  		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> +
> +	dw_hdma_v0_sync_ll_data(chunk);
> +
>  	/* Doorbell */
>  	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
>  }
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
