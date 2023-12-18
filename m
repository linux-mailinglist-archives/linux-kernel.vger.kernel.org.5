Return-Path: <linux-kernel+bounces-3242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD388169C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F50284C00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A764F11C9B;
	Mon, 18 Dec 2023 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="or+Sj3VP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5F12B71;
	Mon, 18 Dec 2023 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0B87A57E;
	Mon, 18 Dec 2023 10:21:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1702891304;
	bh=g0lk6Neev7gf+bIP/pLlo3mUF5ESVh/oDZVLWQU8T0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=or+Sj3VPxglXYVC5WSSWAZ4pSLwTMcjz9oJdKhKYDVra76CJxw3AButmg/f3I3ROY
	 LQjnvIUIxclqeEzbQ8MoFpTEy5GdAu95+VcJEUMfJAWjW/0FRzAY/beyH2acuUpfzj
	 uHCGDq5S6IQzU43aVttCC8DzzEdVkz5wt7EIv5M8=
Date: Mon, 18 Dec 2023 11:22:40 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Mikhail Rudenko <mike.rudenko@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: rkisp1: Fix IRQ handling due to shared
 interrupts
Message-ID: <20231218092240.GB26540@pendragon.ideasonboard.com>
References: <20231218-rkisp-shirq-fix-v1-0-173007628248@ideasonboard.com>
 <20231218-rkisp-shirq-fix-v1-2-173007628248@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218-rkisp-shirq-fix-v1-2-173007628248@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Mon, Dec 18, 2023 at 09:54:01AM +0200, Tomi Valkeinen wrote:
> The driver requests the interrupts as IRQF_SHARED, so the interrupt
> handlers can be called at any time. If such a call happens while the ISP
> is powered down, the SoC will hang as the driver tries to access the
> ISP registers.
> 
> This can be reproduced even without the platform sharing the IRQ line:
> Enable CONFIG_DEBUG_SHIRQ and unload the driver, and the board will
> hang.
> 
> Fix this by adding a new field, 'irqs_enabled', which is used to bail
> out from the interrupt handler when the ISP is not operational.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  .../platform/rockchip/rkisp1/rkisp1-capture.c      |  3 +++
>  .../media/platform/rockchip/rkisp1/rkisp1-common.h |  2 ++
>  .../media/platform/rockchip/rkisp1/rkisp1-csi.c    |  3 +++
>  .../media/platform/rockchip/rkisp1/rkisp1-dev.c    | 22 ++++++++++++++++++++++
>  .../media/platform/rockchip/rkisp1/rkisp1-isp.c    |  3 +++
>  5 files changed, 33 insertions(+)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> index aebd3c12020b..c381c22135a2 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -725,6 +725,9 @@ irqreturn_t rkisp1_capture_isr(int irq, void *ctx)
>  	unsigned int i;
>  	u32 status;
>  
> +	if (!rkisp1->irqs_enabled)
> +		return IRQ_NONE;

Given that this is something all drivers that use shared IRQs have to
do, would it make sense to use a standard helper here, such as
pm_runtime_suspended() for instance ? I haven't looked at which one
would be the most appropriate (if any), there's also
pm_runtime_active() and pm_runtime_status_suspended(). That would
simplify this patch.

> +
>  	status = rkisp1_read(rkisp1, RKISP1_CIF_MI_MIS);
>  	if (!status)
>  		return IRQ_NONE;
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index 4b6b28c05b89..b757f75edecf 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -450,6 +450,7 @@ struct rkisp1_debug {
>   * @debug:	   debug params to be exposed on debugfs
>   * @info:	   version-specific ISP information
>   * @irqs:          IRQ line numbers
> + * @irqs_enabled:  the hardware is enabled and can cause interrupts
>   */
>  struct rkisp1_device {
>  	void __iomem *base_addr;
> @@ -471,6 +472,7 @@ struct rkisp1_device {
>  	struct rkisp1_debug debug;
>  	const struct rkisp1_info *info;
>  	int irqs[RKISP1_NUM_IRQS];
> +	bool irqs_enabled;
>  };
>  
>  /*
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> index b6e47e2f1b94..4202642e0523 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> @@ -196,6 +196,9 @@ irqreturn_t rkisp1_csi_isr(int irq, void *ctx)
>  	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
>  	u32 val, status;
>  
> +	if (!rkisp1->irqs_enabled)
> +		return IRQ_NONE;
> +
>  	status = rkisp1_read(rkisp1, RKISP1_CIF_MIPI_MIS);
>  	if (!status)
>  		return IRQ_NONE;
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index acc559652d6e..73cf08a74011 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -305,6 +305,24 @@ static int __maybe_unused rkisp1_runtime_suspend(struct device *dev)
>  {
>  	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
>  
> +	rkisp1->irqs_enabled = false;
> +	/* Make sure the IRQ handler will see the above */
> +	mb();
> +
> +	/*
> +	 * Wait until any running IRQ handler has returned. The IRQ handler
> +	 * may get called even after this (as it's a shared interrupt line)
> +	 * but the 'irqs_enabled' flag will make the handler return immediately.
> +	 */
> +	for (unsigned int il = 0; il < ARRAY_SIZE(rkisp1->irqs); ++il) {
> +		if (rkisp1->irqs[il] == -1)
> +			continue;
> +
> +		/* Skip if the irq line is the same as previous */
> +		if (il == 0 || rkisp1->irqs[il - 1] != rkisp1->irqs[il])
> +			synchronize_irq(rkisp1->irqs[il]);
> +	}
> +
>  	clk_bulk_disable_unprepare(rkisp1->clk_size, rkisp1->clks);
>  	return pinctrl_pm_select_sleep_state(dev);
>  }
> @@ -321,6 +339,10 @@ static int __maybe_unused rkisp1_runtime_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	rkisp1->irqs_enabled = true;
> +	/* Make sure the IRQ handler will see the above */
> +	mb();
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> index f00873d31c42..78a1f7a1499b 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> @@ -976,6 +976,9 @@ irqreturn_t rkisp1_isp_isr(int irq, void *ctx)
>  	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
>  	u32 status, isp_err;
>  
> +	if (!rkisp1->irqs_enabled)
> +		return IRQ_NONE;
> +
>  	status = rkisp1_read(rkisp1, RKISP1_CIF_ISP_MIS);
>  	if (!status)
>  		return IRQ_NONE;

-- 
Regards,

Laurent Pinchart

