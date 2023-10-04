Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167107B8DCD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244004AbjJDUDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243904AbjJDUDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:03:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC3DA6;
        Wed,  4 Oct 2023 13:03:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 72D99512;
        Wed,  4 Oct 2023 22:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696449676;
        bh=0STMK2shPjMjsQukEfpqITFlDa95uBPhYrYGLXI0PEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UuN/D/NqSW5H3isdNNa8PFd9VnukkabGY/Q9HzuvWLRRJ9ovArpfwP1staoCVqKcF
         reog/uTRvO3jJWkWfg7rJXw4Q7HvoeYzF+ZsGfXYQnbTxQ1+17XPwGT/JaZyuhOHPA
         Xo7yuPzSK2GC4A+3TEcfzCeOXBKu7SlmSp7+GFhU=
Date:   Wed, 4 Oct 2023 23:03:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Jai Luthra <j-luthra@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>, nm@ti.com,
        devarsht@ti.com, a-bhatia1@ti.com,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
Subject: Re: [PATCH v9 13/13] media: ti: Add CSI2RX support for J721E
Message-ID: <20231004200312.GE30342@pendragon.ideasonboard.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
 <20230811-upstream_csi-v9-13-8943f7a68a81@ti.com>
 <ad042065-33a2-d42e-ce2e-628464102fc3@ideasonboard.com>
 <wgkjek77bolf5wabki7uhm6cxjy5g5z2ncoc6urr7dv5y6wnaw@yfh7ccogxfea>
 <20230829155513.GG6477@pendragon.ideasonboard.com>
 <ZR1txMVk+4oHLEKU@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZR1txMVk+4oHLEKU@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 07:21:00PM +0530, Vinod Koul wrote:
> On 29-08-23, 18:55, Laurent Pinchart wrote:
> > Hi Jai,
> > 
> > (CC'ing Vinod, the maintainer of the DMA engine subsystem, for a
> > question below)
> 
> Sorry this got lost

No worries.

> > On Fri, Aug 18, 2023 at 03:55:06PM +0530, Jai Luthra wrote:
> > > On Aug 15, 2023 at 16:00:51 +0300, Tomi Valkeinen wrote:
> > > > On 11/08/2023 13:47, Jai Luthra wrote:
> > > > > From: Pratyush Yadav <p.yadav@ti.com>
> > 
> > [snip]
> > 
> > > > > +static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
> > > > > +{
> > > > > +	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vq);
> > > > > +	struct ti_csi2rx_dma *dma = &csi->dma;
> > > > > +	struct ti_csi2rx_buffer *buf;
> > > > > +	unsigned long flags;
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	spin_lock_irqsave(&dma->lock, flags);
> > > > > +	if (list_empty(&dma->queue))
> > > > > +		ret = -EIO;
> > > > > +	spin_unlock_irqrestore(&dma->lock, flags);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	dma->drain.len = csi->v_fmt.fmt.pix.sizeimage;
> > > > > +	dma->drain.vaddr = dma_alloc_coherent(csi->dev, dma->drain.len,
> > > > > +					      &dma->drain.paddr, GFP_KERNEL);
> > > > > +	if (!dma->drain.vaddr)
> > > > > +		return -ENOMEM;
> > > > 
> > > > This is still allocating a large buffer every time streaming is started (and
> > > > with streams support, a separate buffer for each stream?).
> > > > 
> > > > Did you check if the TI DMA can do writes to a constant address? That would
> > > > be the best option, as then the whole buffer allocation problem goes away.
> > > 
> > > I checked with Vignesh, the hardware can support a scenario where we 
> > > flush out all the data without allocating a buffer, but I couldn't find 
> > > a way to signal that via the current dmaengine framework APIs. Will look 
> > > into it further as it will be important for multi-stream support.
> > 
> > That would be the best option. It's not immediately apparent to me if
> > the DMA engine API supports such a use case.
> > dmaengine_prep_interleaved_dma() gives you finer grain control on the
> > source and destination increments, but I haven't seen a way to instruct
> > the DMA engine to direct writes to /dev/null (so to speak). Vinod, is
> > this something that is supported, or could be supported ?
> 
> Write to a dummy buffer could have the same behaviour, no?

Yes, but if the DMA engine can write to /dev/null, that avoids
allocating a dummy buffer, which is nicer. For video use cases, dummy
buffers are often large.

> > > > Alternatively, can you flush the buffers with multiple one line transfers?
> > > > The flushing shouldn't be performance critical, so even if that's slower
> > > > than a normal full-frame DMA, it shouldn't matter much. And if that can be
> > > > done, a single probe time line-buffer allocation should do the trick.
> > > 
> > > There will be considerable overhead if we queue many DMA transactions 
> > > (in the order of 1000s or even 100s), which might not be okay for the 
> > > scenarios where we have to drain mid-stream. Will have to run some 
> > > experiments to see if that is worth it.
> > > 
> > > But one optimization we can for sure do is re-use a single drain buffer 
> > > for all the streams. We will need to ensure to re-allocate the buffer 
> > > for the "largest" framesize supported across the different streams at 
> > > stream-on time.
> > 
> > If you implement .device_prep_interleaved_dma() in the DMA engine driver
> > you could write to a single line buffer, assuming that the hardware would
> > support so in a generic way.
> > 
> > > My guess is the endpoint is not buffering a full-frame's worth of data, 
> > > I will also check if we can upper bound that size to something feasible.
> > > 
> > > > Other than this drain buffer topic, I think this looks fine. So, I'm going
> > > > to give Rb, but I do encourage you to look more into optimizing this drain
> > > > buffer.
> > > 
> > > Thank you!
> > > 
> > > > Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
