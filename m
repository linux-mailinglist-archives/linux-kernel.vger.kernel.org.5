Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4619761E85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjGYQ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjGYQ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:29:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F41F1723;
        Tue, 25 Jul 2023 09:29:08 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E3D714AD;
        Tue, 25 Jul 2023 18:28:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690302488;
        bh=568xO1KfCfd9modMgC890lLavj5lknuL1KF7VDmcX0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcWWLnEVztr+rLBDgndSy4xPgWEpy4jxmFI4S5KfAAS7uXkBipNJsiIoZwUs3WPkU
         9WkjuZmM6IJWDziGDBy6ufYYD/68/BvPtraeF0Lcois7S+2KzEhZya9cFzS0mhCK9B
         Qvffz2n34rYvCCVi7Pswg1rLmpC0qZGXU3q6dgC0=
Date:   Tue, 25 Jul 2023 19:29:13 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] media: i2c: ds90ub960: Configure CSI-2 continuous
 clock
Message-ID: <20230725162913.GH31069@pendragon.ideasonboard.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
 <20230720-fpdlink-additions-v2-1-b91b1eca2ad3@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720-fpdlink-additions-v2-1-b91b1eca2ad3@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Thu, Jul 20, 2023 at 01:30:32PM +0300, Tomi Valkeinen wrote:
> Use 'clock-noncontinuous' from DT to configure the
> continuous/non-continuous clock setting for the TX ports.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/ds90ub960.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
> index b9a1ef63629b..a83091f47140 100644
> --- a/drivers/media/i2c/ds90ub960.c
> +++ b/drivers/media/i2c/ds90ub960.c
> @@ -149,6 +149,7 @@
>  
>  #define UB960_TR_CSI_CTL			0x33
>  #define UB960_TR_CSI_CTL_CSI_CAL_EN		BIT(6)
> +#define UB960_TR_CSI_CTL_CSI_CONTS_CLOCK	BIT(1)
>  #define UB960_TR_CSI_CTL_CSI_ENABLE		BIT(0)
>  
>  #define UB960_TR_CSI_CTL2			0x34
> @@ -485,6 +486,7 @@ struct ub960_txport {
>  	u8                      nport;	/* TX port number, and index in priv->txport[] */
>  
>  	u32 num_data_lanes;
> +	bool non_continous_clk;
>  };
>  
>  struct ub960_data {
> @@ -1133,6 +1135,9 @@ static int ub960_parse_dt_txport(struct ub960_data *priv,
>  		goto err_free_txport;
>  	}
>  
> +	txport->non_continous_clk = vep.bus.mipi_csi2.flags &
> +				    V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK;
> +
>  	txport->num_data_lanes = vep.bus.mipi_csi2.num_data_lanes;
>  
>  	if (vep.nr_of_link_frequencies != 1) {
> @@ -1744,6 +1749,9 @@ static void ub960_init_tx_port(struct ub960_data *priv,
>  
>  	csi_ctl |= (4 - txport->num_data_lanes) << 4;
>  
> +	if (!txport->non_continous_clk)
> +		csi_ctl |= UB960_TR_CSI_CTL_CSI_CONTS_CLOCK;
> +
>  	ub960_txport_write(priv, nport, UB960_TR_CSI_CTL, csi_ctl);
>  }
>  

-- 
Regards,

Laurent Pinchart
