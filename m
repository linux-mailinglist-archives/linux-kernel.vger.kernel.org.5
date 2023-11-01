Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11617DE32D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344131AbjKAObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjKAObA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:31:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0725710F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:30:55 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 515308D;
        Wed,  1 Nov 2023 15:30:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698849036;
        bh=5YItRrUaGKRTGgloO8CSQlNybPFcehQUacBIcp7TFQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BY7/rBVV1WFwrTtf9vUXoH1UVOHSVGHJ7DfBOi29HZc8FJlCDQoKrtISkCZvR82NN
         7Y0uvzumAePtTS15gmrDGnV+DAeQz3LE2ti+Tn1wZKCp4uLkpwfKf8ItBPV1hOIYQ2
         7B4mf2NRF7V/bDqC2CsbQf++NTst6E/rZMT5rO2A=
Date:   Wed, 1 Nov 2023 16:30:59 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] drm/tidss: Fix dss reset
Message-ID: <20231101143059.GW12764@pendragon.ideasonboard.com>
References: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
 <20231101-tidss-probe-v1-7-45149e0f9415@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101-tidss-probe-v1-7-45149e0f9415@ideasonboard.com>
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

On Wed, Nov 01, 2023 at 11:17:44AM +0200, Tomi Valkeinen wrote:
> The probe function calls dispc_softreset() before runtime PM is enabled
> and without enabling any of the DSS clocks. This happens to work by
> luck, and we need to make sure the DSS HW is active and the fclk is
> enabled.
> 
> To fix the above, add a new function, dispc_init_hw(), which does:
> 
> - pm_runtime_set_active()
> - clk_prepare_enable(fclk)
> - dispc_softreset().
> 
> This ensures that the reset can be successfully accomplished.
> 
> Note that we use pm_runtime_set_active(), not the normal
> pm_runtime_get(). The reason for this is that at this point we haven't
> enabled the runtime PM yet and also we don't want the normal resume
> callback to be called: the dispc resume callback does some initial HW
> setup, and it expects that the HW was off (no video ports are
> streaming). If the bootloader has enabled the DSS and has set up a
> boot time splash-screen, the DSS would be enabled and streaming which
> might lead to issues with the normal resume callback.

I think the right way to do this would be, in probe(), to

- power on the device
- enable runtime PM, masking the device as active
- at end of probe, calling pm_runtime_put_autosuspend()

Please also see my review of patch 02/10.

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 45 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index f204a0701e9f..13db062892e3 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -2724,6 +2724,49 @@ static int dispc_softreset(struct dispc_device *dispc)
>  	return 0;
>  }
>  
> +static int dispc_init_hw(struct dispc_device *dispc)
> +{
> +	struct device *dev = dispc->dev;
> +	int ret;
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to set DSS PM to active\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(dispc->fclk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable DSS fclk\n");
> +		goto err_runtime_suspend;
> +	}
> +
> +	ret = dispc_softreset(dispc);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	clk_disable_unprepare(dispc->fclk);
> +	ret = pm_runtime_set_suspended(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to set DSS PM to suspended\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +
> +err_clk_disable:
> +	clk_disable_unprepare(dispc->fclk);
> +
> +err_runtime_suspend:
> +	ret = pm_runtime_set_suspended(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to set DSS PM to suspended\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
>  int dispc_init(struct tidss_device *tidss)
>  {
>  	struct device *dev = tidss->dev;
> @@ -2835,7 +2878,7 @@ int dispc_init(struct tidss_device *tidss)
>  
>  	tidss->dispc = dispc;
>  
> -	r = dispc_softreset(dispc);
> +	r = dispc_init_hw(dispc);
>  	if (r)
>  		return r;
>  

-- 
Regards,

Laurent Pinchart
