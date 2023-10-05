Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAFE7BA249
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjJEP0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjJEPZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:25:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91C86078A;
        Thu,  5 Oct 2023 07:51:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BB1C433CB;
        Thu,  5 Oct 2023 04:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696479019;
        bh=tvQ6HmqskzVwBQufXqWAzijK9xLx9i/yIFRHr3dsOjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUGQPMVmdNnKQ0RoWKzH79W5T8AWaX52R5iZQaBiaKi+e773J54Ahe6zZ3s7p6pzB
         WtHdPYGr1LFupPbB+ZUJHOVLwqBeJcNuVaAgf2Vvwwy1uSv28lE6HX9NRGq87B6o7a
         Zab4J1b51rBp2Dz+Z5xRryrrFhRn5XE6a9VBlk/YCHq2OrREr9bBjDnTIpO2cfd0XP
         CXadHlD2fzWFoS+FrMbrYO/ncV/jrXyO+QQ354YZO2Bl0VdsYTI7n3L+UO3wc6FAWf
         F3ZgLzlbZwKm1ej4WRH/RHNWsUY2mPVvDBLyXar3PUyTQ8rrqsg+EQnloOmdkoJbhH
         +DN+dx1Jhy6Fw==
Date:   Thu, 5 Oct 2023 09:40:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Message-ID: <ZR43Jre2j51j0mFk@matsya>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
 <20230811-upstream_csi-v9-13-8943f7a68a81@ti.com>
 <ad042065-33a2-d42e-ce2e-628464102fc3@ideasonboard.com>
 <wgkjek77bolf5wabki7uhm6cxjy5g5z2ncoc6urr7dv5y6wnaw@yfh7ccogxfea>
 <20230829155513.GG6477@pendragon.ideasonboard.com>
 <ZR1txMVk+4oHLEKU@matsya>
 <20231004200312.GE30342@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004200312.GE30342@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-10-23, 23:03, Laurent Pinchart wrote:
> On Wed, Oct 04, 2023 at 07:21:00PM +0530, Vinod Koul wrote:
> > On 29-08-23, 18:55, Laurent Pinchart wrote:
> > > Hi Jai,
> > > 
> > > (CC'ing Vinod, the maintainer of the DMA engine subsystem, for a
> > > question below)
> > 
> > Sorry this got lost
> 
> No worries.
> 
> > > On Fri, Aug 18, 2023 at 03:55:06PM +0530, Jai Luthra wrote:
> > > > On Aug 15, 2023 at 16:00:51 +0300, Tomi Valkeinen wrote:
> > > > > On 11/08/2023 13:47, Jai Luthra wrote:
> > > > > > From: Pratyush Yadav <p.yadav@ti.com>
> > > 
> > > [snip]
> > > 
> > > > > > +static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
> > > > > > +{
> > > > > > +	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vq);
> > > > > > +	struct ti_csi2rx_dma *dma = &csi->dma;
> > > > > > +	struct ti_csi2rx_buffer *buf;
> > > > > > +	unsigned long flags;
> > > > > > +	int ret = 0;
> > > > > > +
> > > > > > +	spin_lock_irqsave(&dma->lock, flags);
> > > > > > +	if (list_empty(&dma->queue))
> > > > > > +		ret = -EIO;
> > > > > > +	spin_unlock_irqrestore(&dma->lock, flags);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	dma->drain.len = csi->v_fmt.fmt.pix.sizeimage;
> > > > > > +	dma->drain.vaddr = dma_alloc_coherent(csi->dev, dma->drain.len,
> > > > > > +					      &dma->drain.paddr, GFP_KERNEL);
> > > > > > +	if (!dma->drain.vaddr)
> > > > > > +		return -ENOMEM;
> > > > > 
> > > > > This is still allocating a large buffer every time streaming is started (and
> > > > > with streams support, a separate buffer for each stream?).
> > > > > 
> > > > > Did you check if the TI DMA can do writes to a constant address? That would
> > > > > be the best option, as then the whole buffer allocation problem goes away.
> > > > 
> > > > I checked with Vignesh, the hardware can support a scenario where we 
> > > > flush out all the data without allocating a buffer, but I couldn't find 
> > > > a way to signal that via the current dmaengine framework APIs. Will look 
> > > > into it further as it will be important for multi-stream support.
> > > 
> > > That would be the best option. It's not immediately apparent to me if
> > > the DMA engine API supports such a use case.
> > > dmaengine_prep_interleaved_dma() gives you finer grain control on the
> > > source and destination increments, but I haven't seen a way to instruct
> > > the DMA engine to direct writes to /dev/null (so to speak). Vinod, is
> > > this something that is supported, or could be supported ?
> > 
> > Write to a dummy buffer could have the same behaviour, no?
> 
> Yes, but if the DMA engine can write to /dev/null, that avoids
> allocating a dummy buffer, which is nicer. For video use cases, dummy
> buffers are often large.

hmmm maybe I haven't comprehended it full, would you mind explaining the
details on how such a potential interleaved transfer would look like so
that we can model it or change apis to model this

-- 
~Vinod
