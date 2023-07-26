Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817B276398A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjGZOtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjGZOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:49:19 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04941FCF;
        Wed, 26 Jul 2023 07:49:18 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 17205440;
        Wed, 26 Jul 2023 16:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690382898;
        bh=RgG5/0+5domW5jt/7Gb6bcMhhHTNY27l1OiM4TlQ4+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCV4Limumqzn/BQ6hO4FUR1Uk7CDVhKADUxcoWK/D3dV6ajiP9N5pzNGfpn4d8lIO
         zKGsdmTGCF19JIh387tHn1XHp8supWKYxn4LO9nLmKRlQZF/uyxWx/asJ+vsYZ0tPe
         MovvrhdcJIZP6KtBv9m2epEB+zebPUzVrE6l8MgU=
Date:   Wed, 26 Jul 2023 17:49:23 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Wang Ming <machel@vivo.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] media: platform: Use dev_err_probe instead of dev_err
Message-ID: <20230726144923.GA28136@pendragon.ideasonboard.com>
References: <20230726115208.5463-1-machel@vivo.com>
 <20230726142835.GA5148@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230726142835.GA5148@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 05:28:37PM +0300, Laurent Pinchart wrote:
> Hi Wang,
> 
> Thank you for the patch.
> 
> On Wed, Jul 26, 2023 at 07:51:58PM +0800, Wang Ming wrote:
> > It is possible that dma_request_chan will return EPROBE_DEFER,
> > which means that dma->xdev->dev is not ready yet. In this case,
> > dev_err(dma->xdev->dev), there will be no output. This patch
> > fixes the bug.
> 
> It's not a bug. The existing code works as expected. dev_err_probe() is
> nicer though, as it records the reason for the probe deferral. Here's a
> proposal for a better commit message:
> 
>   It is possible that dma_request_chan() returns EPROBE_DEFER, in which
>   case the driver defers probing without printing any message. Use
>   dev_err_probe() to record the probe deferral cause and ease debugging.
> 
> If you're fine with this, there's no need to resubmit, I'll update the
> commit message locally and merge the patch.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > Signed-off-by: Wang Ming <machel@vivo.com>
> > ---
> >  drivers/media/platform/xilinx/xilinx-dma.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/media/platform/xilinx/xilinx-dma.c b/drivers/media/platform/xilinx/xilinx-dma.c
> > index 80d6f5b072ea..16ad39bef6c6 100644
> > --- a/drivers/media/platform/xilinx/xilinx-dma.c
> > +++ b/drivers/media/platform/xilinx/xilinx-dma.c
> > @@ -708,9 +708,8 @@ int xvip_dma_init(struct xvip_composite_device *xdev, struct xvip_dma *dma,
> >  	snprintf(name, sizeof(name), "port%u", port);
> >  	dma->dma = dma_request_chan(dma->xdev->dev, name);
> >  	if (IS_ERR(dma->dma)) {
> > -		ret = PTR_ERR(dma->dma);
> > -		if (ret != -EPROBE_DEFER)
> > -			dev_err(dma->xdev->dev, "no VDMA channel found\n");
> > +		ret = dev_err_probe(dma->xdev->dev, PTR_ERR(dma->dma),
> > +			"no VDMA channel found\n");

I forgot to mention that the message should be aligned:

		ret = dev_err_probe(dma->xdev->dev, PTR_ERR(dma->dma),
				    "no VDMA channel found\n");

I can fix this locally too.

> >  		goto error;
> >  	}
> >  

-- 
Regards,

Laurent Pinchart
