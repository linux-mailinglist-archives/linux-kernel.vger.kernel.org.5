Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A40780C752
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjLKKyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjLKKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:53:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2711EA1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:54:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304A1C433C7;
        Mon, 11 Dec 2023 10:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702292045;
        bh=Mew19YXARFjy0JbYv18LDqEwa392ENZRfLl+eSvOMKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJ2xmnKNSkDBALZLpUjhCE29HPVqxORPSTSbZ46jS2m+jtpo7r2n4BUX0Xm4zvOTH
         YO6lfYSyBivPT45enhCace80oThVdPEhEZEJYn0MZp9oKA1FTQh47NItT2oQV2KZjQ
         wyfZAZXpCQ2DGEdq0HEf/ax/d61eVh6BFo3fpdKdQgM6pR4w1Uekomk54AxzcGz7w0
         0YJ0t67KITwfy6FW8SkEs3PSMEqCO0o1ipj9vPM0TigyFZgRHxuj7QrDHXh+6bvxUi
         ywroaL9KQdcVubnmIOpoV4uW+UsVhxjOi3v4x99zDQ1lkA/Ehr5TGlRptO25obv3RO
         ju07LyRJ7ZK3Q==
Date:   Mon, 11 Dec 2023 16:24:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jan Kuliga <jankul@alatek.krakow.pl>
Cc:     lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
        michal.simek@amd.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH v4 4/8] dmaengine: xilinx: xdma: Rework
 xdma_terminate_all()
Message-ID: <ZXbqSQ9W/VrAA0ZE@matsya>
References: <20231208134838.49500-1-jankul@alatek.krakow.pl>
 <20231208134929.49523-5-jankul@alatek.krakow.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208134929.49523-5-jankul@alatek.krakow.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-12-23, 14:49, Jan Kuliga wrote:
> Simplify xdma_xfer_stop(). Stop the dma engine and clear its status
> register unconditionally - just do what its name states. This change
> also allows to call it without grabbing a lock, which minimizes
> the total time spent with a spinlock held.
> 
> Delete the currently processed vd.node from the vc.desc_issued list
> prior to passing it to vchan_terminate_vdesc(). In case there's more
> than one descriptor pending on vc.desc_issued list, calling
> vchan_terminate_desc() results in losing the link between
> vc.desc_issued list head and the second descriptor on the list. Doing so
> results in resources leakege, as vchan_dma_desc_free_list() won't be
> able to properly free memory resources attached to descriptors,
> resulting in dma_pool_destroy() failure.
> 
> Don't call vchan_dma_desc_free_list() from within xdma_terminate_all().
> Move all terminated descriptors to the vc.desc_terminated list instead.
> This allows to postpone freeing memory resources associated with
> descriptors until the call to vchan_synchronize(), which is called from
> xdma_synchronize() callback. This is the right way to do it -
> xdma_terminate_all() should return as soon as possible, while freeing
> resources (that may be time consuming in case of large number of
> descriptors) can be done safely later.
> 
> Fixes: 290bb5d2d1e2
> ("dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks")
> 
> Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
> ---
>  drivers/dma/xilinx/xdma.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 1bce48e5d86c..521ba2a653b6 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -379,20 +379,20 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
>   */
>  static int xdma_xfer_stop(struct xdma_chan *xchan)
>  {
> -	struct virt_dma_desc *vd = vchan_next_desc(&xchan->vchan);
> -	struct xdma_device *xdev = xchan->xdev_hdl;
>  	int ret;
> -
> -	if (!vd || !xchan->busy)
> -		return -EINVAL;
> +	u32 val;
> +	struct xdma_device *xdev = xchan->xdev_hdl;
> 
>  	/* clear run stop bit to prevent any further auto-triggering */
>  	ret = regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_CONTROL_W1C,
> -			   CHAN_CTRL_RUN_STOP);
> +							CHAN_CTRL_RUN_STOP);

Why this change, checkpatch would tell you this is not expected
alignment (run with strict)

>  	if (ret)
>  		return ret;
> 
> -	xchan->busy = false;
> +	/* Clear the channel status register */
> +	ret = regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &val);
> +	if (ret)
> +		return ret;
> 
>  	return 0;
>  }
> @@ -505,25 +505,25 @@ static void xdma_issue_pending(struct dma_chan *chan)
>  static int xdma_terminate_all(struct dma_chan *chan)
>  {
>  	struct xdma_chan *xdma_chan = to_xdma_chan(chan);
> -	struct xdma_desc *desc = NULL;
>  	struct virt_dma_desc *vd;
>  	unsigned long flags;
>  	LIST_HEAD(head);
> 
> -	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
>  	xdma_xfer_stop(xdma_chan);
> 
> +	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
> +
> +	xdma_chan->busy = false;
>  	vd = vchan_next_desc(&xdma_chan->vchan);
> -	if (vd)
> -		desc = to_xdma_desc(vd);
> -	if (desc) {
> -		dma_cookie_complete(&desc->vdesc.tx);
> -		vchan_terminate_vdesc(&desc->vdesc);
> +	if (vd) {
> +		list_del(&vd->node);
> +		dma_cookie_complete(&vd->tx);
> +		vchan_terminate_vdesc(vd);
>  	}
> -
>  	vchan_get_all_descriptors(&xdma_chan->vchan, &head);
> +	list_splice_tail(&head, &xdma_chan->vchan.desc_terminated);
> +
>  	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> -	vchan_dma_desc_free_list(&xdma_chan->vchan, &head);
> 
>  	return 0;
>  }
> --
> 2.34.1

-- 
~Vinod
