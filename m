Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AED7EED2C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345710AbjKQII6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjKQIIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:08:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A28131
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:08:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA81C433C7;
        Fri, 17 Nov 2023 08:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700208529;
        bh=HJEtSlR2M5HLiOxVxrCGWQb4pam62naOtP++t26z2iM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUfA0Pj8JG63mQwdDf3sR2/Dn/dhIdm3bHnL5P+aRL89q9qLinL77fiJiTECUxBen
         Vx5jBSPVYDw/Ey1JmqFOJb93v2oft1VP8bOjHG5Gi4BQklNejRNuopPknmf4kRmlpu
         JVCKKeysqMFLilK8BmhEXMIUdhJ4PckONU0sB4CnkPP4ew89GZVY76GHPizoBIDPtW
         33+Y+xmFZwXaV39BirtxxadqwyKiRGKylIuqXfp56upviS5bdrzQto3IwJiIIA0WO6
         QwK6S1rgKwUdcstRLJRdHkkxrcBbkvnVU6gUs3ArjntPZ1ayzET0Q+wgrjyh7ijgp8
         l5b3YM0nYBw+A==
Date:   Fri, 17 Nov 2023 13:38:43 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v5 6/6] dmaengine: dw-edma: eDMA: Add sync read before
 starting the DMA transfer in remote setup
Message-ID: <20231117080843.GE10361@thinkpad>
References: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
 <20231114-b4-feature_hdma_mainline-v5-6-7bc86d83c6f7@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114-b4-feature_hdma_mainline-v5-6-7bc86d83c6f7@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 03:51:59PM +0100, Kory Maincent wrote:
> The Linked list element and pointer are not stored in the same memory as
> the eDMA controller register. If the doorbell register is toggled before
> the full write of the linked list a race condition error will occur.
> In remote setup we can only use a readl to the memory to assure the full
> write has occurred.
> 
> Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Same comment as patch 5/6. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v2:
> - New patch
> 
> Changes in v4:
> - Update git commit message.
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index b38786f0ad79..6245b720fbfe 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -346,6 +346,20 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
>  }
>  
> +static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
> +{
> +	/*
> +	 * In case of remote eDMA engine setup, the DW PCIe RP/EP internals
> +	 * configuration registers and Application memory are normally accessed
> +	 * over different buses. Ensure LL-data reaches the memory before the
> +	 * doorbell register is toggled by issuing the dummy-read from the remote
> +	 * LL memory in a hope that the posted MRd TLP will return only after the
> +	 * last MWr TLP is completed
> +	 */
> +	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		readl(chunk->ll_region.vaddr.io);
> +}
> +
>  static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
> @@ -412,6 +426,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>  			  upper_32_bits(chunk->ll_region.paddr));
>  	}
> +
> +	dw_edma_v0_sync_ll_data(chunk);
> +
>  	/* Doorbell */
>  	SET_RW_32(dw, chan->dir, doorbell,
>  		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
