Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FAC78B7CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjH1TEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjH1TDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:03:46 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7458F191;
        Mon, 28 Aug 2023 12:03:42 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 88ED7741;
        Mon, 28 Aug 2023 21:02:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693249338;
        bh=EQ5Ed7YSUu9pnyDqHnRnEXM2hGzRvbt5Ebt+ytf7N64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCtDnkhdUy7M5KwcMvRC241ho+8Tq6PJkEuAhQ0F9SouSyP6PvkS32HgZd627J05F
         AWXb53lvxm/sARULaWXsFUFPq2+sC+XAJE7/ADtFVk+I1Yd7d8mtUvm+xSclXgEhvA
         0+W7oBkLYi9BAntE+xEVo37475TnDOL1CCOCZxP8=
Date:   Mon, 28 Aug 2023 22:03:49 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/15] media: qcom: camss: Support RDI3 for VFE 17x
Message-ID: <20230828190349.GQ14596@pendragon.ideasonboard.com>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-14-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104444.1954663-14-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

Thank you for the patch.

On Wed, Aug 23, 2023 at 11:44:42AM +0100, Bryan O'Donoghue wrote:
> Some VFEs have four RDIs apiece. Right now the ISR code has a hard-coded
> value which tops-out at RDI2 meaning only three RDIs can be utilised in
> practice.
> 
> Extend out the various routines in camss-vfe-17x.c to support the higher
> RDI count.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/qcom/camss/camss-vfe-170.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
> index 8aa921400ded0..c2487a8196db7 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
> @@ -210,7 +210,8 @@ static void vfe_global_reset(struct vfe_device *vfe)
>  			 GLOBAL_RESET_CMD_IDLE_CGC	|
>  			 GLOBAL_RESET_CMD_RDI0		|
>  			 GLOBAL_RESET_CMD_RDI1		|
> -			 GLOBAL_RESET_CMD_RDI2;
> +			 GLOBAL_RESET_CMD_RDI2		|
> +			 GLOBAL_RESET_CMD_RDI3;
>  
>  	writel_relaxed(BIT(31), vfe->base + VFE_IRQ_MASK_0);
>  
> @@ -344,7 +345,7 @@ static void vfe_violation_read(struct vfe_device *vfe)
>  static irqreturn_t vfe_isr(int irq, void *dev)
>  {
>  	struct vfe_device *vfe = dev;
> -	u32 status0, status1, vfe_bus_status[3];
> +	u32 status0, status1, vfe_bus_status[VFE_LINE_NUM_MAX];
>  	int i, wm;
>  
>  	status0 = readl_relaxed(vfe->base + VFE_IRQ_STATUS_0);
> @@ -353,7 +354,7 @@ static irqreturn_t vfe_isr(int irq, void *dev)
>  	writel_relaxed(status0, vfe->base + VFE_IRQ_CLEAR_0);
>  	writel_relaxed(status1, vfe->base + VFE_IRQ_CLEAR_1);
>  
> -	for (i = VFE_LINE_RDI0; i <= VFE_LINE_RDI2; i++) {
> +	for (i = VFE_LINE_RDI0; i < vfe->line_num; i++) {
>  		vfe_bus_status[i] = readl_relaxed(vfe->base + VFE_BUS_IRQ_STATUS(i));
>  		writel_relaxed(vfe_bus_status[i], vfe->base + VFE_BUS_IRQ_CLEAR(i));
>  	}
> @@ -367,11 +368,11 @@ static irqreturn_t vfe_isr(int irq, void *dev)
>  	if (status0 & STATUS_0_RESET_ACK)
>  		vfe->isr_ops.reset_ack(vfe);
>  
> -	for (i = VFE_LINE_RDI0; i <= VFE_LINE_RDI2; i++)
> +	for (i = VFE_LINE_RDI0; i < vfe->line_num; i++)
>  		if (status0 & STATUS_0_RDI_REG_UPDATE(i))
>  			vfe->isr_ops.reg_update(vfe, i);
>  
> -	for (i = VFE_LINE_RDI0; i <= VFE_LINE_RDI2; i++)
> +	for (i = VFE_LINE_RDI0; i < vfe->line_num; i++)
>  		if (status0 & STATUS_1_RDI_SOF(i))
>  			vfe->isr_ops.sof(vfe, i);
>  

-- 
Regards,

Laurent Pinchart
