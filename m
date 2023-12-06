Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEB5807B33
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377108AbjLFWNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjLFWM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:12:59 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0107DDE;
        Wed,  6 Dec 2023 14:13:04 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F1441556;
        Wed,  6 Dec 2023 23:12:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701900742;
        bh=MyiZ0c9R7mhTEt9Q8JKoeIvrzUNTttSdhrpWfhqCogE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMp2vAP7F/Z8TOEz4aQAFWxGxRVpyCWPin+FZNaj8aiBvsICy14SbeuqEFb3c2LrR
         aZettZBcgw6+h7/serhV0khPIeOsV21Xg0EICis0YA7YuKnsvNHW5ZgH1UhQ3q71h5
         gK9A8sBWNSjy5ZXtE833/BI3GLT+3AiwdOhSSc6w=
Date:   Thu, 7 Dec 2023 00:13:09 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        kieran.bingham@ideasonboard.com, umang.jain@ideasonboard.com,
        aford173@gmail.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] media: rkisp1: Fix IRQ disable race issue
Message-ID: <20231206221309.GD29417@pendragon.ideasonboard.com>
References: <20231206-rkisp-irq-fix-v2-0-6ba4185eeb1f@ideasonboard.com>
 <20231206-rkisp-irq-fix-v2-4-6ba4185eeb1f@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206-rkisp-irq-fix-v2-4-6ba4185eeb1f@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Wed, Dec 06, 2023 at 12:12:31PM +0200, Tomi Valkeinen wrote:
> In rkisp1_isp_stop() and rkisp1_csi_disable() the driver masks the
> interrupts and then apparently assumes that the interrupt handler won't
> be running, and proceeds in the stop procedure. This is not the case, as
> the interrupt handler can already be running, which would lead to the
> ISP being disabled while the interrupt handler handling a captured
> frame.
> 
> This brings up two issues: 1) the ISP could be powered off while the
> interrupt handler is still running and accessing registers, leading to
> board lockup, and 2) the interrupt handler code and the code that
> disables the streaming might do things that conflict.
> 
> It is not clear to me if 2) causes a real issue, but 1) can be seen with
> a suitable delay (or printk in my case) in the interrupt handler,
> leading to board lockup.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c | 14 +++++++++++++-
>  drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c | 20 +++++++++++++++++---
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> index 47f4353a1784..0bab3303f2e4 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> @@ -125,8 +125,20 @@ static void rkisp1_csi_disable(struct rkisp1_csi *csi)
>  	struct rkisp1_device *rkisp1 = csi->rkisp1;
>  	u32 val;
>  
> -	/* Mask and clear interrupts. */
> +	/* Mask MIPI interrupts. */
>  	rkisp1_write(rkisp1, RKISP1_CIF_MIPI_IMSC, 0);
> +
> +	/* Flush posted writes */
> +	rkisp1_read(rkisp1, RKISP1_CIF_MIPI_IMSC);
> +
> +	/*
> +	 * Wait until the IRQ handler has ended. The IRQ handler may get called
> +	 * even after this, but it will return immediately as the MIPI
> +	 * interrupts have been masked.
> +	 */
> +	synchronize_irq(rkisp1->irqs[RKISP1_IRQ_MIPI]);
> +
> +	/* Clear MIPI interrupt status */
>  	rkisp1_write(rkisp1, RKISP1_CIF_MIPI_ICR, ~0);
>  
>  	val = rkisp1_read(rkisp1, RKISP1_CIF_MIPI_CTRL);
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> index dafbfd230542..33b5a714d117 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> @@ -364,11 +364,25 @@ static void rkisp1_isp_stop(struct rkisp1_isp *isp)
>  	 * ISP(mi) stop in mi frame end -> Stop ISP(mipi) ->
>  	 * Stop ISP(isp) ->wait for ISP isp off
>  	 */
> -	/* stop and clear MI and ISP interrupts */
> -	rkisp1_write(rkisp1, RKISP1_CIF_ISP_IMSC, 0);
> -	rkisp1_write(rkisp1, RKISP1_CIF_ISP_ICR, ~0);
>  
> +	/* Mask MI and ISP interrupts */
> +	rkisp1_write(rkisp1, RKISP1_CIF_ISP_IMSC, 0);
>  	rkisp1_write(rkisp1, RKISP1_CIF_MI_IMSC, 0);
> +
> +	/* Flush posted writes */
> +	rkisp1_read(rkisp1, RKISP1_CIF_MI_IMSC);
> +
> +	/*
> +	 * Wait until the IRQ handler has ended. The IRQ handler may get called
> +	 * even after this, but it will return immediately as the MI and ISP
> +	 * interrupts have been masked.
> +	 */
> +	synchronize_irq(rkisp1->irqs[RKISP1_IRQ_ISP]);
> +	if (rkisp1->irqs[RKISP1_IRQ_ISP] != rkisp1->irqs[RKISP1_IRQ_MI])
> +		synchronize_irq(rkisp1->irqs[RKISP1_IRQ_MI]);
> +
> +	/* Clear MI and ISP interrupt status */
> +	rkisp1_write(rkisp1, RKISP1_CIF_ISP_ICR, ~0);
>  	rkisp1_write(rkisp1, RKISP1_CIF_MI_ICR, ~0);
>  
>  	/* stop ISP */

-- 
Regards,

Laurent Pinchart
