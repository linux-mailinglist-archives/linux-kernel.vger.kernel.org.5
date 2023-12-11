Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B02380C75C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjLKKyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbjLKKyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:54:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0F9F2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:54:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6F6C433C8;
        Mon, 11 Dec 2023 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702292084;
        bh=BsHdeJO+VdYNGqLVNFanltGKbE5xp7hh0b7y/NioNh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdXAbsnTPeBzkUV49rrm+8BHCXL1GrauQEjZ1xD1cTxcDbPT7iRs/dX1nYv/WztM5
         rYJjRE8VzwyjBaPhoBhI/bQ0pyNcpprQMjHFuuIjwwaSt+IPyDd7ZayTaKcu4NP55m
         9gtu2S+xvpSrCqTHaKRGughnRlc2AypkgptqRqNBey5ZEuaeeMG8ddgOPTGRC4I+oM
         OvvxLS1uDPHAZf0/jL2Rn/1yVf1VThaIPiGGijho0AeBrnKyawhnyoPn+7wcVQqvcO
         EUi5slbpVwiQUkRYH3r1V1yGKe9iH68ga5/vKB3PqTDjPHnc3ZnXPKEPvOepLqbVJT
         E8dxPIrzf2l8g==
Date:   Mon, 11 Dec 2023 16:24:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jan Kuliga <jankul@alatek.krakow.pl>
Cc:     lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
        michal.simek@amd.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: [FIXED PATCH v4 6/8] dmaengine: xilinx: xdma: Add transfer error
 reporting
Message-ID: <ZXbqcGSL6oVD8YDS@matsya>
References: <9d683987-53db-a53e-9215-3a29f0167183@amd.com>
 <20231208220802.56458-1-jankul@alatek.krakow.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208220802.56458-1-jankul@alatek.krakow.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-12-23, 23:08, Jan Kuliga wrote:
> Extend the capability of transfer status reporting. Introduce error flag,
> which allows to report error in case of a interrupt-reported error
> condition.

Pls post the updated series, noting changes from last rev

> 
> Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
> ---
>  drivers/dma/xilinx/xdma.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index d1bc36133a45..a7cd378b7e9a 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -85,6 +85,7 @@ struct xdma_chan {
>   * @cyclic: Cyclic transfer vs. scatter-gather
>   * @periods: Number of periods in the cyclic transfer
>   * @period_size: Size of a period in bytes in cyclic transfers
> + * @error: tx error flag
>   */
>  struct xdma_desc {
>  	struct virt_dma_desc		vdesc;
> @@ -97,6 +98,7 @@ struct xdma_desc {
>  	bool				cyclic;
>  	u32				periods;
>  	u32				period_size;
> +	bool				error;
>  };
> 
>  #define XDMA_DEV_STATUS_REG_DMA		BIT(0)
> @@ -274,6 +276,7 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num, bool cyclic)
>  	sw_desc->chan = chan;
>  	sw_desc->desc_num = desc_num;
>  	sw_desc->cyclic = cyclic;
> +	sw_desc->error = false;
>  	dblk_num = DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
>  	sw_desc->desc_blocks = kcalloc(dblk_num, sizeof(*sw_desc->desc_blocks),
>  				       GFP_NOWAIT);
> @@ -770,20 +773,20 @@ static enum dma_status xdma_tx_status(struct dma_chan *chan, dma_cookie_t cookie
>  	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
> 
>  	vd = vchan_find_desc(&xdma_chan->vchan, cookie);
> -	if (vd)
> -		desc = to_xdma_desc(vd);
> -	if (!desc || !desc->cyclic) {
> -		spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> -		return ret;
> -	}
> -
> -	period_idx = desc->completed_desc_num % desc->periods;
> -	residue = (desc->periods - period_idx) * desc->period_size;
> +	if (!vd)
> +		goto out;
> 
> +	desc = to_xdma_desc(vd);
> +	if (desc->error) {
> +		ret = DMA_ERROR;
> +	} else if (desc->cyclic) {
> +		period_idx = desc->completed_desc_num % desc->periods;
> +		residue = (desc->periods - period_idx) * desc->period_size;
> +		dma_set_residue(state, residue);
> +	}
> +out:
>  	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> 
> -	dma_set_residue(state, residue);
> -
>  	return ret;
>  }
> 
> @@ -820,6 +823,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
>  	st &= XDMA_CHAN_STATUS_MASK;
>  	if ((st & XDMA_CHAN_ERROR_MASK) ||
>  		!(st & (CHAN_CTRL_IE_DESC_COMPLETED | CHAN_CTRL_IE_DESC_STOPPED))) {
> +		desc->error = true;
>  		xdma_err(xdev, "channel error, status register value: 0x%x", st);
>  		goto out;
>  	}
> --
> 2.34.1

-- 
~Vinod
