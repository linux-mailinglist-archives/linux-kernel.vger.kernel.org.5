Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135D0808ADC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443344AbjLGOmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443322AbjLGOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:42:00 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97834FA;
        Thu,  7 Dec 2023 06:42:06 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0E0DB669;
        Thu,  7 Dec 2023 15:41:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701960083;
        bh=oqYzC0d84cVaTRAlruVMVWSCZEKZ2kE5XcA+BUxZl7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SwCJCfORVcentryBcSckPtg8b/RXbRVFLvkA2AlDqc504HhDgXnytdpNS6y2aPKGs
         prQTHuebFcf4ErDU9P882Kk/rHHV5b9sfwCcP/A8SqKyJQ7s45x90xbImYCCpuyzMk
         0yua0I3ffFDTSWPKEqEnty4316GOe/MFArXHNqRE=
Date:   Thu, 7 Dec 2023 16:42:10 +0200
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
Subject: Re: [PATCH v3 3/4] media: rkisp1: Store IRQ lines
Message-ID: <20231207144210.GE15521@pendragon.ideasonboard.com>
References: <20231207-rkisp-irq-fix-v3-0-358a2c871a3c@ideasonboard.com>
 <20231207-rkisp-irq-fix-v3-3-358a2c871a3c@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207-rkisp-irq-fix-v3-3-358a2c871a3c@ideasonboard.com>
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

On Thu, Dec 07, 2023 at 09:57:47AM +0200, Tomi Valkeinen wrote:
> Store the IRQ lines used by the driver for easy access. These are needed
> in future patches which fix IRQ race issues.
> 
> Tested-by: Adam Ford <aford173@gmail.com>  #imx8mp-beacon
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-common.h | 11 ++++++++++-
>  drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c    | 17 +++++++++++++----
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index 1e7cea1bea5e..2d7f06281c39 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -61,6 +61,14 @@ struct dentry;
>  						 RKISP1_CIF_ISP_EXP_END |	\
>  						 RKISP1_CIF_ISP_HIST_MEASURE_RDY)
>  
> +/* IRQ lines */
> +enum rkisp1_irq_line {
> +	RKISP1_IRQ_ISP = 0,
> +	RKISP1_IRQ_MI,
> +	RKISP1_IRQ_MIPI,
> +	RKISP1_NUM_IRQS,
> +};
> +
>  /* enum for the resizer pads */
>  enum rkisp1_rsz_pad {
>  	RKISP1_RSZ_PAD_SINK,
> @@ -423,7 +431,6 @@ struct rkisp1_debug {
>   * struct rkisp1_device - ISP platform device
>   *
>   * @base_addr:	   base register address
> - * @irq:	   the irq number
>   * @dev:	   a pointer to the struct device
>   * @clk_size:	   number of clocks
>   * @clks:	   array of clocks
> @@ -441,6 +448,7 @@ struct rkisp1_debug {
>   * @stream_lock:   serializes {start/stop}_streaming callbacks between the capture devices.
>   * @debug:	   debug params to be exposed on debugfs
>   * @info:	   version-specific ISP information
> + * @irqs:          IRQ line numbers
>   */
>  struct rkisp1_device {
>  	void __iomem *base_addr;
> @@ -461,6 +469,7 @@ struct rkisp1_device {
>  	struct mutex stream_lock; /* serialize {start/stop}_streaming cb between capture devices */
>  	struct rkisp1_debug debug;
>  	const struct rkisp1_info *info;
> +	int irqs[RKISP1_NUM_IRQS];
>  };
>  
>  /*
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index 22b2ae0e89c4..c3fa40976140 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -114,6 +114,7 @@
>  struct rkisp1_isr_data {
>  	const char *name;
>  	irqreturn_t (*isr)(int irq, void *ctx);
> +	u32 line_mask;
>  };
>  
>  /* ----------------------------------------------------------------------------
> @@ -471,9 +472,9 @@ static const char * const px30_isp_clks[] = {
>  };
>  
>  static const struct rkisp1_isr_data px30_isp_isrs[] = {
> -	{ "isp", rkisp1_isp_isr },
> -	{ "mi", rkisp1_capture_isr },
> -	{ "mipi", rkisp1_csi_isr },
> +	{ "isp", rkisp1_isp_isr, BIT(RKISP1_IRQ_ISP) },
> +	{ "mi", rkisp1_capture_isr, BIT(RKISP1_IRQ_MI) },
> +	{ "mipi", rkisp1_csi_isr, BIT(RKISP1_IRQ_MIPI) },
>  };
>  
>  static const struct rkisp1_info px30_isp_info = {
> @@ -492,7 +493,7 @@ static const char * const rk3399_isp_clks[] = {
>  };
>  
>  static const struct rkisp1_isr_data rk3399_isp_isrs[] = {
> -	{ NULL, rkisp1_isr },
> +	{ NULL, rkisp1_isr, BIT(RKISP1_IRQ_ISP) | BIT(RKISP1_IRQ_MI) | BIT(RKISP1_IRQ_MIPI) },
>  };
>  
>  static const struct rkisp1_info rk3399_isp_info = {
> @@ -543,6 +544,9 @@ static int rkisp1_probe(struct platform_device *pdev)
>  	if (IS_ERR(rkisp1->base_addr))
>  		return PTR_ERR(rkisp1->base_addr);
>  
> +	for (unsigned int il = 0; il < ARRAY_SIZE(rkisp1->irqs); ++il)
> +		rkisp1->irqs[il] = -1;
> +
>  	for (i = 0; i < info->isr_size; i++) {
>  		irq = info->isrs[i].name
>  		    ? platform_get_irq_byname(pdev, info->isrs[i].name)
> @@ -550,6 +554,11 @@ static int rkisp1_probe(struct platform_device *pdev)
>  		if (irq < 0)
>  			return irq;
>  
> +		for (unsigned int il = 0; il < ARRAY_SIZE(rkisp1->irqs); ++il) {
> +			if (info->isrs[i].line_mask & BIT(il))
> +				rkisp1->irqs[il] = irq;
> +		}
> +
>  		ret = devm_request_irq(dev, irq, info->isrs[i].isr, 0,
>  				       dev_driver_string(dev), dev);
>  		if (ret) {
> 

-- 
Regards,

Laurent Pinchart
