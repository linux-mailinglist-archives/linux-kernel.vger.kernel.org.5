Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE076398D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjGZOu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjGZOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:50:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D33519BE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:50:55 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 13814440;
        Wed, 26 Jul 2023 16:49:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690382995;
        bh=MQfRZf/H3BgoNNCWVRlZoYaGK5CIedLjl0BElcFRs4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9uAPYx7aHrGamXP/wlIEBWZOhnPqw0qofifXN2Mcmn8KRZOYkTipsPYbk/KtetDO
         9Eq66WgWqcuwdAMvsSXgbfbhDvD7ligUVvBYcjGMgPxW+rsMjk3TPyvnhsn0mEv2It
         zNiSbCOZgAwrCOrxRLsSrRh0eH/LG09r+U0DaRnE=
Date:   Wed, 26 Jul 2023 17:51:00 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Wang Ming <machel@vivo.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@amd.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] gpu: drm: Use dev_err_probe instead of dev_err
Message-ID: <20230726145100.GB5148@pendragon.ideasonboard.com>
References: <20230726115806.5702-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230726115806.5702-1-machel@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

Thank you for the patch.

On Wed, Jul 26, 2023 at 07:57:56PM +0800, Wang Ming wrote:
> It is possible that dma_request_chan will return EPROBE_DEFER,
> which means that disp->dev is not ready yet. In this case,
> dev_err(disp->dev), there will be no output. This patch fixes the bug.

It's not a bug. The existing code works as expected. dev_err_probe() is
nicer though, as it records the reason for the probe deferral. Here's a
proposal for a better commit message:

  It is possible that dma_request_chan() returns EPROBE_DEFER, in which
  case the driver defers probing without printing any message. Use
  dev_err_probe() to record the probe deferral cause and ease debugging.

> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index 3b87eebddc97..676f09fe8594 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -1094,8 +1094,8 @@ static int zynqmp_disp_layer_request_dma(struct zynqmp_disp *disp,
>  			 "%s%u", dma_names[layer->id], i);
>  		dma->chan = dma_request_chan(disp->dev, dma_channel_name);
>  		if (IS_ERR(dma->chan)) {
> -			dev_err(disp->dev, "failed to request dma channel\n");
> -			ret = PTR_ERR(dma->chan);
> +			ret = dev_err_probe(disp->dev, PTR_ERR(dma->chan),
> +				"failed to request dma channel\n");

The alignment is wrong, this should be

			ret = dev_err_probe(disp->dev, PTR_ERR(dma->chan),
					    "failed to request dma channel\n");

If you're fine with those changes, I can fix this locally, there's no
need to resubmit.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  			dma->chan = NULL;
>  			return ret;
>  		}

-- 
Regards,

Laurent Pinchart
